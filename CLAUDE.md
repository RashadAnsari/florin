# Florin - Claude Code Instructions

These rules are the source of truth for working in this repository. Always read and follow this file before making code changes or refactors.

## General rules

- No duplicate components: reuse existing ones with props rather than creating variants.
- **No duplicate code**: before writing a constant, function, or utility, search the codebase first. If it already exists, import it, never redefine it. Shared logic belongs in `lib/services/`. Shared UI belongs in `lib/widgets/`. Shared constants live in the relevant service file.
- **Punctuation**: no period on short labels, headings, button text, and single-phrase descriptions. Use a period on full sentences, especially multi-clause ones (FAQs, warnings, longer descriptions).
- **Em dash**: never use the em dash character (—) in any user-facing text, copy, labels, or metadata. Use a colon, comma, or period instead.
- **Translations**: all user-facing strings must go through `AppLocalizations` — never hardcode text visible to the user. Add keys to both `app_en.arb` and `app_nl.arb`.
- **Required fields**: every required form field label must end with ` *` (e.g., `Name *`). No exceptions across all forms.
- **Theme**: always use the project theme defined in `lib/theme/`. Never invent colors, typography, spacing, or any design tokens. Never create a parallel design system. All UI decisions must reference `lib/theme/` exclusively.

## UI design rules

- **List screen structure**: `Column` with search bar + `Divider(height: 1)` + `Expanded(ListView)` — never put `ListView` directly as `body`. Match the invoices/expenses pattern.
- **Tile spacing**: use `SizedBox(height: 2)` between rows inside list tiles — consistent across all screens.
- **Checkboxes**: always use `controlAffinity: ListTileControlAffinity.leading` on `CheckboxListTile` — checkbox on left, label on right. Right-side checkbox looks like an unrelated section header.
- **maxLength fields**: always add `counterText: ''` to `InputDecoration` — hides the character counter that breaks vertical alignment with adjacent fields.
- **Destructive buttons**: delete `IconButton` must use `color: theme.colorScheme.error` — never a silent grey destructive action.
- **External link buttons**: use `OutlinedButton.icon` with `Icons.open_in_new` when a button opens a URL.
- **Primary action buttons**: use `FilledButton.icon` with `backgroundColor: theme.colorScheme.primaryContainer` and `foregroundColor: theme.colorScheme.onPrimaryContainer` — visible in both light and dark mode.
- **Detail/form pages fill the screen**: detail panels and forms must always fill all available width. Never wrap form content in `ConstrainedBox`, `SizedBox(width:)`, or any fixed-width container — let the `Column` expand to fill the `Expanded`/`SingleChildScrollView` naturally.
- **Form validation errors**: always show inline field errors, never toasts. Use `Form` + `GlobalKey<FormState>` + `validator` on each required field. For button-triggered checks (e.g., VIES), use a `String? _fieldError` state variable and wire it to `InputDecoration.errorText`, clearing it `onChanged`. Toasts are only for success feedback (saved, created, deleted).

<!-- ================================================== -->

# Ruflo — Claude Code Configuration

## Rules

- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary — prefer editing existing files
- NEVER create documentation files unless explicitly requested
- NEVER save working files or tests to root — use `/src`, `/tests`, `/docs`, `/config`, `/scripts`
- ALWAYS read a file before editing it
- NEVER commit secrets, credentials, or .env files
- Keep files under 500 lines
- Validate input at system boundaries

## Agent Comms (SendMessage-First Coordination)

Named agents coordinate via `SendMessage`, not polling or shared state.

```
Lead (you) ←→ architect ←→ developer ←→ tester ←→ reviewer
              (named agents message each other directly)
```

### Spawning a Coordinated Team

```javascript
// ALL agents in ONE message, each knows WHO to message next
Agent({ prompt: "Research the codebase. SendMessage findings to 'architect'.",
  subagent_type: "researcher", name: "researcher", run_in_background: true })
Agent({ prompt: "Wait for 'researcher'. Design solution. SendMessage to 'coder'.",
  subagent_type: "system-architect", name: "architect", run_in_background: true })
Agent({ prompt: "Wait for 'architect'. Implement it. SendMessage to 'tester'.",
  subagent_type: "coder", name: "coder", run_in_background: true })
Agent({ prompt: "Wait for 'coder'. Write tests. SendMessage results to 'reviewer'.",
  subagent_type: "tester", name: "tester", run_in_background: true })
Agent({ prompt: "Wait for 'tester'. Review code quality and security.",
  subagent_type: "reviewer", name: "reviewer", run_in_background: true })

// Kick off the pipeline
SendMessage({ to: "researcher", summary: "Start", message: "[task context]" })
```

### Patterns

| Pattern | Flow | Use When |
|---------|------|----------|
| **Pipeline** | A → B → C → D | Sequential dependencies (feature dev) |
| **Fan-out** | Lead → A, B, C → Lead | Independent parallel work (research) |
| **Supervisor** | Lead ↔ workers | Ongoing coordination (complex refactor) |

### Rules

- ALWAYS name agents — `name: "role"` makes them addressable
- ALWAYS include comms instructions in prompts — who to message, what to send
- Spawn ALL agents in ONE message with `run_in_background: true`
- After spawning: STOP, tell user what's running, wait for results
- NEVER poll status — agents message back or complete automatically

## Swarm & Routing

### Config
- **Topology**: hierarchical-mesh (anti-drift)
- **Max Agents**: 15
- **Memory**: hybrid
- **HNSW**: Enabled
- **Neural**: Enabled

```bash
npx @claude-flow/cli@latest swarm init --topology hierarchical --max-agents 8 --strategy specialized
```

### Agent Routing

| Task | Agents | Topology |
|------|--------|----------|
| Bug Fix | researcher, coder, tester | hierarchical |
| Feature | architect, coder, tester, reviewer | hierarchical |
| Refactor | architect, coder, reviewer | hierarchical |
| Performance | perf-engineer, coder | hierarchical |
| Security | security-architect, auditor | hierarchical |

### When to Swarm
- **YES**: 3+ files, new features, cross-module refactoring, API changes, security, performance
- **NO**: single file edits, 1-2 line fixes, docs updates, config changes, questions

### 3-Tier Model Routing

| Tier | Handler | Use Cases |
|------|---------|-----------|
| 1 | Agent Booster (WASM) | Simple transforms — skip LLM, use Edit directly |
| 2 | Haiku | Simple tasks, low complexity |
| 3 | Sonnet/Opus | Architecture, security, complex reasoning |

## Memory & Learning

### Before Any Task
```bash
npx @claude-flow/cli@latest memory search --query "[task keywords]" --namespace patterns
npx @claude-flow/cli@latest hooks route --task "[task description]"
```

### After Success
```bash
npx @claude-flow/cli@latest memory store --namespace patterns --key "[name]" --value "[what worked]"
npx @claude-flow/cli@latest hooks post-task --task-id "[id]" --success true --store-results true
```

### MCP Tools (use `ToolSearch("keyword")` to discover)

| Category | Key Tools |
|----------|-----------|
| **Memory** | `memory_store`, `memory_search`, `memory_search_unified` |
| **Bridge** | `memory_import_claude`, `memory_bridge_status` |
| **Swarm** | `swarm_init`, `swarm_status`, `swarm_health` |
| **Agents** | `agent_spawn`, `agent_list`, `agent_status` |
| **Hooks** | `hooks_route`, `hooks_post-task`, `hooks_worker-dispatch` |
| **Security** | `aidefence_scan`, `aidefence_is_safe`, `aidefence_has_pii` |
| **Hive-Mind** | `hive-mind_init`, `hive-mind_consensus`, `hive-mind_spawn` |

### Background Workers

| Worker | When |
|--------|------|
| `audit` | After security changes |
| `optimize` | After performance work |
| `testgaps` | After adding features |
| `map` | Every 5+ file changes |
| `document` | After API changes |

```bash
npx @claude-flow/cli@latest hooks worker dispatch --trigger audit
```

## Agents

**Core**: `coder`, `reviewer`, `tester`, `planner`, `researcher`
**Architecture**: `system-architect`, `backend-dev`, `mobile-dev`
**Security**: `security-architect`, `security-auditor`
**Performance**: `performance-engineer`, `perf-analyzer`
**Coordination**: `hierarchical-coordinator`, `mesh-coordinator`, `adaptive-coordinator`
**GitHub**: `pr-manager`, `code-review-swarm`, `issue-tracker`, `release-manager`

Any string works as a custom agent type.

## Build & Test

- ALWAYS run tests after code changes
- ALWAYS verify build succeeds before committing

```bash
npm run build && npm test
```

## CLI Quick Reference

```bash
npx @claude-flow/cli@latest init --wizard           # Setup
npx @claude-flow/cli@latest swarm init --v3-mode     # Start swarm
npx @claude-flow/cli@latest memory search --query "" # Vector search
npx @claude-flow/cli@latest hooks route --task ""    # Route to agent
npx @claude-flow/cli@latest doctor --fix             # Diagnostics
npx @claude-flow/cli@latest security scan            # Security scan
npx @claude-flow/cli@latest performance benchmark    # Benchmarks
```

26 commands, 140+ subcommands. Use `--help` on any command for details.

## Setup

```bash
claude mcp add claude-flow -- npx -y @claude-flow/cli@latest
npx @claude-flow/cli@latest daemon start
npx @claude-flow/cli@latest doctor --fix
```

**Agent tool** handles execution (agents, files, code, git). **MCP tools** handle coordination (swarm, memory, hooks). **CLI** is the same via Bash.
