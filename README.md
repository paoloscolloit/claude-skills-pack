# Claude Skills Pack

> Configurazione completa di skill per Claude Code · Complete Claude Code skill configuration

---

## Flusso di lavoro / Workflow

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
