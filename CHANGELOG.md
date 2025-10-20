# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - XXXX-XX-XX

### Changed

- `/commit` command now automatically creates feature branches instead of just warning about main/master commits
  - Automatic branch naming patterns:
    - `feature/feat-<description>` for new features
    - `fix/<description>` for bug fixes
    - `chore/<description>` for maintenance tasks
    - `docs/<description>` for documentation updates

### Added

- Shell safety rules enforcing zsh usage for terminal operations
- Mandatory zsh shell verification in safety and workflow rules
- Explicit prohibition of fish, bash, and other shells in favor of zsh

## [1.0.0] - 2024-12-19

### Added

- Initial release with comprehensive Cursor configuration
- 10 custom commands for Git, Kubernetes, and project management
- 5 safety hooks for dangerous operation prevention
- 4 comprehensive rule files for development standards
- Complete documentation and examples
