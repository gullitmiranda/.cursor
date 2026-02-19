---
name: Import and re-import unified flow
overview: 'Implementar as definições acordadas: fluxo único de processamento de containers (ZIP/EML), self-healing de blob ao detectar "já existe", notificação única com [Reprocessar] [Ver arquivos] (sem "Reimportar"), e notificação pós-processamento sobre revisões.'
todos: []
isProject: false
---

# Import and re-import unified flow

## Context and definitions (summary)

- **Single flow:** One logic for "process this container" (ZIP/EML) for both first import and reprocess: always consider that container and children may already exist (by hash/name) → update/adopt or create; guarantee blob when matching existing.
- **Re-import is not automatic:** When we detect "already exists", we do **self-healing** (ensure blob) but do **not** run the pipeline; user must choose "Reprocessar" if they want to re-run.
- **Single notification for "already exists":** Message like "Arquivo(s) já foi/foram importado(s)." with actions **[Reprocessar]** and **[Ver arquivos]** only (no "Reimportar").
- **Post-processing notification:** When processing (new and/or existing) finishes, show a notification about **reviews** (e.g. "X itens para revisar" with "Ver revisões").
- **Backend:** When detecting existing (same hash or name), **guarantee blob** (store if missing) and return structured result (imported / already_existed / failed) so the frontend can show the single notification and actions.

---

## Current state (brief)

- **[import.rs](crates/fenda-tauri/src/commands/import.rs):** `import_zip` already detects duplicate ZIP by hash, ensures blob if missing, returns `was_duplicate`, `duplicate_sources`, `new_sources`. `import_file` has a TODO for duplicate check and always creates a new source.
- **[import_reprocess.rs](crates/fenda-tauri/src/commands/import_reprocess.rs):** `reprocess_zip` / `reprocess_email` implement backfill/adopt/create and blob guarantee for existing EMLs and attachments; logic is **different** from `import_zip` (which only checks duplicate at ZIP level then always creates children).
- **Frontend:** [global-drop-zone.tsx](apps/desktop/src/features/import/components/global-drop-zone.tsx) calls `createImportSummary` / `showImportNotification` from `../lib/import-notifications` (path from `components/` = `features/import/lib/import-notifications`). That module was not found under `apps/desktop/src/features/import/` (no `lib/` folder), so it may be missing or under a different path; ZIP results are passed to it. Single-file import (OFX/CSV) uses a simple success toast with "Ver arquivos". Reprocess button exists in detail view and table; toast on error "Erro ao reprocessar importação".

---

## Implementation plan

### 1. Backend: Unify container processing (ZIP/EML)

**Goal:** One shared path for "process container content" so that first import and reprocess use the same rules (existing by hash/name → guarantee blob + update/adopt; else create).

- **1.1** Extract the core logic from `reprocess_zip` and `reprocess_email` into a shared module (e.g. under [source_content.rs](crates/fenda-tauri/src/source_content.rs) or a new `process_container` module in fenda-tauri). The function should accept: container type (ZIP | Email), container bytes, parent source (for ZIP: the ZIP ImportSource; for Email: the EML ImportSource), owner_id, book_id, storage, app. It should:
  - For ZIP: parse EMLs + attachments; for each EML, find existing by hash/name among parent’s children → ensure blob, update parent_id if needed, push to result; else create EML source and store blob. For each attachment, find existing among EML’s children by hash/name → ensure blob, update parent_id if needed; else find orphan by hash then by filename (list_all_import_sources); if found, adopt (parent_id + blob); else create and store blob.
  - For Email: same idea for attachments only (find existing by hash/name → blob + update; else adopt by hash/filename; else create).
- **1.2** Change `import_zip` to use this shared logic: after duplicate ZIP check and blob guarantee, if not duplicate, create ZIP ImportSource then call the shared "process container" with the ZIP as parent and the extracted content (or pass bytes and let the shared function do extraction). If duplicate, return current response (already has blob guarantee).
- **1.3** Change `reprocess_container_source` to get container content via `get_content_bytes_for_source` (already done) then call the same shared "process container" function (so reprocess becomes "get content + run same process as import").
- **Outcome:** First import and reprocess of a container run the same "process container" pipeline; no divergent backfill/adopt/create between import.rs and import_reprocess.rs.

### 2. Backend: Self-healing and "already exists" for single file

- **2.1** In [import_file](crates/fenda-tauri/src/commands/import.rs): Before creating a new source, check for existing by hash (`get_import_source_by_hash(owner_id, file_hash)`). If found: ensure blob (`read_blob`; if missing, `store_blob` with current content); return a response that indicates "already existed" (e.g. `already_existed_source_id: Option<String>`, or a small struct `ImportFileResponse { result, already_existed_source_id }`) without creating a new source or running the rest of the pipeline.
- **2.2** Ensure `import_zip` continues to guarantee blob for duplicate ZIP (already implemented) and that the unified container processing (step 1) guarantees blob for any existing child (already in current reprocess logic; keep it in the shared function).

### 3. Backend: Response shape for mixed/batch

- **3.1** Keep/extend [ImportZipResponse](crates/fenda-tauri/src/commands/import.rs) with fields that support notifications: e.g. `new_sources`, `already_existed_sources` (or ids), and optionally `failed` if we add partial failure reporting. Same idea for single-file: `ImportFileResponse` already has `result`; add `already_existed_source_id: Option<String>` when duplicate is detected.
- **3.2** For multiple ZIPs (or multiple files) the frontend already aggregates results (e.g. in global-drop-zone). Ensure the backend returns enough for one aggregated message: e.g. "X importados, Y já existiam" and list of ids for "Ver arquivos" / "Reprocessar" (e.g. already_existed ids so the notification can link to them or trigger reprocess by id).

### 4. Frontend: Notifications module and single "already exists" notification

- **4.1** Create or fix the import notifications module so it exists at a path the frontend can import (e.g. [apps/desktop/src/features/import/lib/import-notifications.ts](apps/desktop/src/features/import/lib/import-notifications.ts) to match `../lib/import-notifications` from `components/global-drop-zone.tsx`). Implement:
  - **Single "already exists" notification:** Message: "Arquivo já foi importado anteriormente." (single) or "X arquivos já foram importados." (multiple). Actions: **[Reprocessar]** (calls `reprocess_import_source` for the existing source id(s)) and **[Ver arquivos]** (navigate to imports list, optionally with sourceIds for highlight).
  - No "Reimportar" action; only "Reprocessar" and "Ver arquivos".
- **4.2** Use this for ZIP results: when `was_duplicate` or when `already_existed_sources` (or equivalent) is non-empty, show the single notification with [Reprocessar] [Ver arquivos]. For single-file import, when `already_existed_source_id` is set, show the same style notification.
- **4.3** Mixed batch: when some imports are new and some already exist, show **one aggregated notification** (e.g. "X arquivos importados. Y já existiam.") with primary action [Ver arquivos]; if Y > 0, include [Reprocessar] (e.g. open list filtered to those ids or show a single "Reprocessar" that reprocesses the first/primary existing source — exact UX can be refined; minimum is one notification with both counts and Ver arquivos).

### 5. Frontend: Post-processing notification (reviews)

- **5.1** After a successful import or reprocess that produces review tasks, show a **second notification** about reviews: e.g. "N itens para revisar" with action "Ver revisões" (navigate to review queue, optionally with a filter). Use the existing response data (e.g. new_sources / child_sources / review task counts) to compute N if available, or trigger a refetch of review tasks and show the count.
- **5.2** Where to hook: in the same place that currently shows success after import (e.g. in global-drop-zone after `showImportNotification`, and in the success path of single-file import and after reprocess in detail/table views). Add a small helper or inline logic: if there are new review tasks (or new sources that imply review tasks), show the review notification with "Ver revisões".

### 6. Frontend: Reprocess action from notification

- **6.1** Ensure [Reprocessar] in the "already exists" notification calls the existing `reprocess_import_source` command with the existing source id (and book_id). Use the same mutation/hook as the detail view (e.g. [useReenqueueImportSource](apps/desktop/src/features/import/hooks/use-import-sources.ts)) so behavior is identical.
- **6.2** Optional: pass sourceIds to the imports route when opening "Ver arquivos" so the list can highlight or scroll to those sources (if the store/URL sync already supports it; see [use-import-sources-url-sync.ts](apps/desktop/src/features/import/hooks/use-import-sources-url-sync.ts)).

### 7. Docs and roadmap

- **7.1** Update [docs/architecture/import-pipeline-flows.md](docs/architecture/import-pipeline-flows.md) (or a short subsection) to state that "process container" is a single flow used by both first import and reprocess, and that "already exists" triggers blob self-healing and a single notification with [Reprocessar] [Ver arquivos].
- **7.2** Optionally add a technical-debt or roadmap item for "Unified container processing (import + reprocess)" and "Single notification for already exists (Reprocessar + Ver arquivos)" if not already covered.

---

## Order of work (suggested)

1. Backend: Self-healing + "already exists" for single file (2.1, 2.2) and response shape (3.1, 3.2) — small, clear change.
2. Backend: Extract shared container processing (1.1), then wire import_zip and reprocess to it (1.2, 1.3).
3. Frontend: Create/fix import-notifications module and single "already exists" notification (4.1–4.3), then Reprocessar from notification (6.1, 6.2).
4. Frontend: Post-processing review notification (5.1, 5.2).
5. Docs (7.1, 7.2).

---

## Files to touch (main)

| Area                                 | Files                                                                                                                                                                                                                                                                                                           |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Backend unified container            | [crates/fenda-tauri/src/commands/import.rs](crates/fenda-tauri/src/commands/import.rs), [crates/fenda-tauri/src/commands/import_reprocess.rs](crates/fenda-tauri/src/commands/import_reprocess.rs), possibly [crates/fenda-tauri/src/source_content.rs](crates/fenda-tauri/src/source_content.rs) or new module |
| Backend single-file duplicate        | [crates/fenda-tauri/src/commands/import.rs](crates/fenda-tauri/src/commands/import.rs) (`import_file`, `ImportFileResponse`)                                                                                                                                                                                    |
| Frontend notifications               | New or fix: `apps/desktop/src/features/import/lib/import-notifications.ts`; [global-drop-zone.tsx](apps/desktop/src/features/import/components/global-drop-zone.tsx); success paths for single-file import and reprocess                                                                                        |
| Frontend reprocess from notification | [use-import-sources.ts](apps/desktop/src/features/import/hooks/use-import-sources.ts) (already has reprocess mutation); import-notifications calls it                                                                                                                                                           |
| Docs                                 | [docs/architecture/import-pipeline-flows.md](docs/architecture/import-pipeline-flows.md); [docs/roadmap.md](docs/roadmap.md) if adding DT                                                                                                                                                                       |
