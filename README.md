# Claude Skills Pack

> Configurazione completa di skill per Claude Code · Complete Claude Code skill configuration

> **Partial support** for Cursor, Gemini CLI, Codex, OpenCode, GitHub Copilot CLI — see [Platform compatibility](#platform-compatibility) below.

---

## Workflow

```
PHASE 0 — Core Philosophy (always active)
└── karpathy-guidelines: think before coding, minimalism, surgical changes

PHASE 1 — Exploration
├── brainstorming: what do you really want? Don't assume it's obvious
└── design-shotgun: if there's UI → generate 3-8 visual variants, pick a direction

PHASE 2 — Planning
└── writing-plans: granular task-by-task plan (2-5 min each)

PHASE 3 — Safety (when touching prod or shared environments)
├── careful: automatic warning before rm -rf, DROP TABLE, force-push
└── guard: careful + block edits outside the specified folder

PHASE 4 — Implementation
├── using-git-worktrees: isolated workspace, never on main
├── test-driven-development: red test → code → green → refactor
├── subagent-driven-development: one agent per task, automatic review
└── dispatching-parallel-agents: independent problems in parallel

PHASE 5 — Quality
├── requesting-code-review: after each significant task
├── receiving-code-review: technical rigor over people-pleasing
└── systematic-debugging: if a bug appears → root cause first, never guess

PHASE 6 — Verification
└── verification-before-completion: no "done" without fresh evidence

PHASE 7 — Closing
├── finishing-a-development-branch: merge / PR / discard with confirmation
└── canary: post-deploy monitoring (console errors, performance regressions)
```

---

## Flusso di lavoro

```
FASE 0 — Filosofia di base (sempre attiva)
└── karpathy-guidelines: pensa prima di codificare, minimalismo, cambiamenti chirurgici

FASE 1 — Esplorazione
├── brainstorming: cosa vuoi davvero? Supponiamo non sia ovvio
└── design-shotgun: se c'è UI → genera 3-8 varianti visive, scegli direzione

FASE 2 — Pianificazione
└── writing-plans: piano granulare task per task (2-5 min ciascuno)

FASE 3 — Sicurezza (se tocchi prod o ambienti condivisi)
├── careful: warn automatico prima di rm -rf, DROP TABLE, force-push
└── guard: careful + blocco modifiche fuori dalla cartella specificata

FASE 4 — Implementazione
├── using-git-worktrees: workspace isolato, mai su main
├── test-driven-development: test rosso → codice → verde → refactor
├── subagent-driven-development: un agente per task, review automatica
└── dispatching-parallel-agents: problemi indipendenti in parallelo

FASE 5 — Qualità
├── requesting-code-review: dopo ogni task significativo
├── receiving-code-review: rispondo con rigore tecnico, non per compiacere
└── systematic-debugging: se emerge un bug → root cause first, mai fix a caso

FASE 6 — Verifica
└── verification-before-completion: nessun "fatto" senza evidenza fresca

FASE 7 — Chiusura
├── finishing-a-development-branch: merge / PR / discard con conferma
└── canary: monitoring post-deploy (errori console, regressioni performance)
```

---

## Platform compatibility

Not all skills work on every AI coding tool. Here's what you get depending on your platform:

| Skill group | Claude Code | Cursor | Gemini CLI | Codex CLI | OpenCode | Copilot CLI |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Superpowers** (14 skills) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **karpathy-guidelines** (philosophy) | ✅ | ✅¹ | ✅¹ | ✅¹ | ✅¹ | ✅¹ |
| **design-shotgun, canary, careful, guard** (gstack) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

¹ Paste the contents of `karpathy-guidelines/SKILL.md` into your tool's system instructions file (`.cursorrules`, `GEMINI.md`, etc.).

### Installing Superpowers on other platforms

| Platform | Command |
|---|---|
| **Cursor** | `/add-plugin superpowers` or search the marketplace |
| **Gemini CLI** | `gemini extensions install https://github.com/obra/superpowers` |
| **Codex CLI** | `/plugins` → select Superpowers → Install |
| **OpenCode** | follow [opencode install instructions](https://raw.githubusercontent.com/obra/superpowers/main/.opencode/INSTALL.md) |
| **GitHub Copilot CLI** | `copilot plugin marketplace add obra/superpowers-marketplace` |
| **Factory Droid** | `droid plugin install superpowers@superpowers` |

The 4 gstack skills (`design-shotgun`, `canary`, `careful`, `guard`) use Claude Code's `PreToolUse` hook system, which has no equivalent in other tools yet.

---

## Compatibilità con le piattaforme

Non tutte le skill funzionano su ogni tool di AI coding. Ecco cosa ottieni in base alla piattaforma:

| Gruppo skill | Claude Code | Cursor | Gemini CLI | Codex CLI | OpenCode | Copilot CLI |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Superpowers** (14 skill) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **karpathy-guidelines** (filosofia) | ✅ | ✅¹ | ✅¹ | ✅¹ | ✅¹ | ✅¹ |
| **design-shotgun, canary, careful, guard** (gstack) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

¹ Incolla il contenuto di `karpathy-guidelines/SKILL.md` nelle istruzioni di sistema del tuo tool (`.cursorrules`, `GEMINI.md`, ecc.).

Le 4 skill gstack usano il sistema di hook `PreToolUse` di Claude Code, che non ha equivalente negli altri tool.

---

## Skills included

| Skill | Source | Phase |
|---|---|---|
| brainstorming, writing-plans, test-driven-development, systematic-debugging, subagent-driven-development, dispatching-parallel-agents, requesting-code-review, receiving-code-review, using-git-worktrees, executing-plans, verification-before-completion, finishing-a-development-branch, writing-skills, using-superpowers | [obra/superpowers](https://github.com/obra/superpowers) | 1–7 |
| design-shotgun | [garrytan/gstack](https://github.com/garrytan/gstack) | 1 |
| careful | [garrytan/gstack](https://github.com/garrytan/gstack) | 3 |
| guard | [garrytan/gstack](https://github.com/garrytan/gstack) | 3 |
| canary | [garrytan/gstack](https://github.com/garrytan/gstack) | 7 |
| karpathy-guidelines | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | 0 |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed

### Step 1 — Superpowers (inside Claude Code)

Open Claude Code and run:

```
/plugin install superpowers@claude-plugins-official
```

### Step 2 — The 5 additional skills (script)

**Windows (PowerShell):**

```powershell
.\install.ps1
```

**Mac / Linux:**

```bash
chmod +x install.sh && ./install.sh
```

### Verify

After installation, type `/brainstorming` or `/karpathy-guidelines` in Claude Code to confirm the skills are active.

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato

### Passo 1 — Superpowers (dentro Claude Code)

Apri Claude Code e digita:

```
/plugin install superpowers@claude-plugins-official
```

### Passo 2 — Le 5 skill aggiuntive (script)

**Windows (PowerShell):**

```powershell
.\install.ps1
```

**Mac / Linux:**

```bash
chmod +x install.sh && ./install.sh
```

### Verifica

Dopo l'installazione, in Claude Code digita `/brainstorming` o `/karpathy-guidelines` per verificare che le skill siano attive.

---

## Update / Aggiornamento

Re-run the install script to update the 5 additional skills to the latest version from their source repos.  
Riesegui lo script di installazione per aggiornare le 5 skill aggiuntive all'ultima versione dai repo originali.
