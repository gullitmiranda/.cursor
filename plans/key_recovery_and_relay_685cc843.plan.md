---
name: Key Recovery and Relay
overview: Definir estratégias de key recovery (recovery phrase com trusted contacts futuro) e cloud relay (self-hosted full sync node com autenticação dual).
todos:
  - id: create-adr-key-recovery
    content: Criar ADR 0003 para key recovery strategy
    status: pending
  - id: create-adr-cloud-relay
    content: Criar ADR 0004 para cloud relay architecture
    status: pending
  - id: create-spec-key-recovery
    content: Criar spec detalhada de key recovery em docs/specs/infrastructure/
    status: pending
  - id: create-spec-cloud-relay
    content: Criar spec detalhada de cloud relay em docs/specs/infrastructure/
    status: pending
---

# Key Recovery e Cloud Relay

## Resumo das Decisões

| Aspecto | Decisão |

|---------|---------|

| Key Recovery | Recovery phrase (24 palavras) + trusted contacts (futuro) |

| Cloud Relay | Self-hosted only, full sync node |

| Relay Auth | Key-based (criptografia) + Token (autorização) |

| Relay Storage | Nativo (SQLite/files) |

---

## 1. Key Recovery

### Modelo de Chaves

```mermaid
flowchart TD
    subgraph derivation [Key Derivation]
        Password[User Password] --> Argon2[Argon2id KDF]
        Argon2 --> MasterKey[Master Key]
        MasterKey --> KEK[Key Encryption Key]
    end

    subgraph storage [Key Storage]
        KEK --> EncryptedKeys[Encrypted Key Bundle]
        EncryptedKeys --> LocalDB[(Local Storage)]
    end

    subgraph recovery [Recovery Path]
        Mnemonic[Recovery Phrase 24w] --> BIP39[BIP39 Seed]
        BIP39 --> RecoveredMaster[Recovered Master Key]
        RecoveredMaster --> RecoveredKEK[Recovered KEK]
        RecoveredKEK --> DecryptBundle[Decrypt Key Bundle]
    end
```

### Recovery Phrase

**Geração:**

- BIP39 mnemonic (24 palavras)
- Entropy: 256 bits
- Checksum incluído
- Suporte multilíngue (EN, PT-BR)

**Fluxo de Setup:**

```mermaid
sequenceDiagram
    participant User
    participant App
    participant Secure as Secure Storage

    User->>App: Criar conta
    App->>App: Gerar entropy 256 bits
    App->>App: Converter para mnemonic BIP39
    App->>User: Mostrar 24 palavras
    User->>App: Confirmar (digitar palavras 3, 8, 15)
    App->>Secure: Armazenar master key derivada
    App->>App: Derivar KEK e data keys
    Note over App: Recovery phrase NUNCA armazenada
```

**Fluxo de Recovery:**

```mermaid
sequenceDiagram
    participant User
    participant NewDevice as New Device
    participant Relay as Relay Server

    User->>NewDevice: Digitar 24 palavras
    NewDevice->>NewDevice: Derivar master key
    NewDevice->>NewDevice: Derivar KEK
    NewDevice->>Relay: Autenticar com public key
    Relay->>NewDevice: Enviar dados criptografados
    NewDevice->>NewDevice: Descriptografar com KEK
    Note over NewDevice: Dados restaurados
```

### Trusted Contacts (Futuro)

Reservado para implementação futura usando Shamir Secret Sharing:

- Usuário escolhe N contatos
- Threshold M de N para recuperar
- Cada contato recebe um share criptografado
- Shares são inúteis individualmente

---

## 2. Cloud Relay

### Arquitetura

```mermaid
flowchart TD
    subgraph devices [User Devices]
        Phone[Mobile App]
        Desktop[Desktop App]
        Tablet[Tablet App]
    end

    subgraph relay [Self-Hosted Relay]
        RelayServer[Relay Server]
        RelayDB[(SQLite)]
        Automerge[Automerge Docs]
    end

    Phone <-->|QUIC/Encrypted| RelayServer
    Desktop <-->|QUIC/Encrypted| RelayServer
    Tablet <-->|QUIC/Encrypted| RelayServer

    RelayServer --> RelayDB
    RelayServer --> Automerge

    Phone <-.->|P2P Direct| Desktop
    Desktop <-.->|P2P Direct| Tablet
```

### Relay como Full Sync Node

O relay funciona como um peer sempre online:

- Mantém cópia completa dos documentos Automerge
- Dados armazenados criptografados (relay não pode ler)
- Sincroniza com qualquer device que conectar
- Resolve como "bridge" quando devices não estão online simultaneamente

### Autenticação Dual

```mermaid
sequenceDiagram
    participant App
    participant Relay

    Note over App,Relay: 1. Token Authorization
    App->>Relay: POST /auth {token: "abc123"}
    Relay->>Relay: Validar token
    Relay->>App: 200 OK {session_id}

    Note over App,Relay: 2. Key-based Encryption
    App->>App: Criptografar dados com public key do user
    App->>Relay: SYNC {encrypted_data}
    Relay->>Relay: Armazenar (não pode descriptografar)

    Note over App,Relay: 3. Outro device sincroniza
    App2->>Relay: GET /sync {session_id}
    Relay->>App2: {encrypted_data}
    App2->>App2: Descriptografar com private key
```

### Configuração do Relay

**No Relay Server:**

1. Deploy do relay (Docker, binary, ou source)
2. Gerar token de acesso
3. Configurar porta e domínio

**No App:**

1. Settings > Sync > Add Relay
2. URL do relay (ex: `https://my-relay.example.com`)
3. Token de acesso
4. Testar conexão

### Relay Server Spec

```text
Relay Server {
  // Config
  port: integer
  storage_path: string
  max_storage_bytes: integer
  allowed_tokens: string[]

  // Endpoints
  POST /auth          // Authenticate with token
  GET  /sync/:doc_id  // Get document state
  POST /sync/:doc_id  // Push document changes
  WS   /realtime      // WebSocket for live sync

  // Storage
  documents/
    {user_id}/
      {doc_id}.automerge
}
```

### Fluxo de Sync com Relay

```mermaid
sequenceDiagram
    participant Phone
    participant Relay
    participant Desktop

    Note over Phone: Phone faz mudança offline
    Phone->>Phone: Update local Automerge

    Note over Phone,Relay: Phone conecta
    Phone->>Relay: Auth + Push changes
    Relay->>Relay: Merge com estado atual
    Relay->>Phone: ACK + conflitos resolvidos

    Note over Desktop,Relay: Desktop conecta depois
    Desktop->>Relay: Auth + Pull
    Relay->>Desktop: Changes desde último sync
    Desktop->>Desktop: Merge local
    Desktop->>Relay: Push local changes
    Relay->>Relay: Merge

    Note over Phone,Desktop: Ambos agora sincronizados via relay
```

---

## 3. Segurança

### Modelo de Ameaças

| Ameaça | Mitigação |

|--------|-----------|

| Relay comprometido | Dados criptografados, relay não tem chaves |

| Token vazado | Revogar token, gerar novo |

| Recovery phrase exposta | Usuário deve gerar nova conta |

| Man-in-the-middle | QUIC com TLS, certificate pinning |

### O que o Relay NÃO pode fazer

- Ler conteúdo dos dados (criptografados)
- Modificar dados sem detecção (Automerge hash chain)
- Impersonar usuário (não tem private key)
- Acessar dados de outros usuários

### O que o Relay PODE fazer (se malicioso)

- Negar serviço (não sincronizar)
- Observar metadados (quando, quanto, frequência)
- Guardar histórico de versões criptografadas

---

## 4. Implementação

### Prioridade

1. **Recovery Phrase** - Crítico para segurança desde o início
2. **Relay Protocol** - Necessário para sync multi-device
3. **Relay Server** - Pode ser implementado depois do protocolo
4. **Trusted Contacts** - Futuro, após validar modelo básico

### Bibliotecas Sugeridas (Rust)

- `bip39` - Geração de mnemonic
- `argon2` - KDF para derivação de chaves
- `x25519-dalek` - Key exchange
- `chacha20poly1305` - Encryption
- `automerge` - CRDT sync
- `quinn` - QUIC transport

---

## 5. Estrutura de Arquivos (Output)

```text
docs/
├── adr/
│   ├── 0003-key-recovery.md      # ADR para key recovery
│   └── 0004-cloud-relay.md       # ADR para cloud relay
└── specs/
    └── infrastructure/
        ├── key-recovery.md       # Spec detalhada
        └── cloud-relay.md        # Spec detalhada
```

---

## Questões em Aberto

- [ ] Rate limiting no relay para prevenir abuse
- [ ] Política de retenção de dados no relay
- [ ] Rotação de tokens de acesso
- [ ] Backup do relay (já que é self-hosted)
