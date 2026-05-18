#!/usr/bin/env bash
# Claude Skills Pack — Mac/Linux installer
#
# Per piattaforma:
#   Claude Code  → installa gstack skills + karpathy come SKILL.md
#   Cursor       → installa karpathy come .mdc rule; rimanda gstack a ./setup --host cursor
#   Altre        → stampa comandi manuali per Superpowers + gstack + karpathy

set -euo pipefail

# ── Helpers ───────────────────────────────────────────────────────────────────

download() {
    local url="$1" dest="$2"
    mkdir -p "$(dirname "$dest")"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    else
        wget -q "$url" -O "$dest"
    fi
}

# ── Platform detection ────────────────────────────────────────────────────────

CLAUDE_DIR="$HOME/.claude"
CURSOR_DIR="$HOME/.cursor"

declare -A OTHER_DIRS=(
    ["Codex CLI"]="$HOME/.codex"
    ["OpenCode"]="$HOME/.config/opencode"
    ["Factory Droid"]="$HOME/.factory"
    ["Slate"]="$HOME/.slate"
    ["Kiro"]="$HOME/.kiro"
    ["Hermes"]="$HOME/.hermes"
    ["GBrain"]="$HOME/.gbrain"
)

declare -A OTHER_HOSTS=(
    ["Codex CLI"]="codex"
    ["OpenCode"]="opencode"
    ["Factory Droid"]="factory"
    ["Slate"]="slate"
    ["Kiro"]="kiro"
    ["Hermes"]="hermes"
    ["GBrain"]="gbrain"
)

declare -A OTHER_SUPERPOWERS=(
    ["Codex CLI"]="/plugins  →  select Superpowers  →  Install"
    ["OpenCode"]="(see https://github.com/obra/superpowers → .opencode/INSTALL.md)"
    ["Factory Droid"]="droid plugin install superpowers@superpowers"
    ["Slate"]="(see gstack docs)"
    ["Kiro"]="(see gstack docs)"
    ["Hermes"]="(see gstack docs)"
    ["GBrain"]="(see gstack docs)"
)

detected_others=()
for name in "${!OTHER_DIRS[@]}"; do
    [ -d "${OTHER_DIRS[$name]}" ] && detected_others+=("$name")
done

# ══ Claude Code ═══════════════════════════════════════════════════════════════

if [ -d "$CLAUDE_DIR" ]; then
    SKILLS_DIR="$CLAUDE_DIR/skills"
    echo ""
    echo "▶ Claude Code — installing to $SKILLS_DIR"
    echo ""

    for skill in design-shotgun canary guard; do
        download \
            "https://raw.githubusercontent.com/garrytan/gstack/main/$skill/SKILL.md" \
            "$SKILLS_DIR/$skill/SKILL.md"
        echo "  [OK] $skill"
    done

    # careful needs its hook script too
    download "https://raw.githubusercontent.com/garrytan/gstack/main/careful/SKILL.md" \
             "$SKILLS_DIR/careful/SKILL.md"
    download "https://raw.githubusercontent.com/garrytan/gstack/main/careful/bin/check-careful.sh" \
             "$SKILLS_DIR/careful/bin/check-careful.sh"
    chmod +x "$SKILLS_DIR/careful/bin/check-careful.sh"
    echo "  [OK] careful"

    download \
        "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/karpathy-guidelines/SKILL.md" \
        "$SKILLS_DIR/karpathy-guidelines/SKILL.md"
    echo "  [OK] karpathy-guidelines"

    echo ""
    echo "  Next: install Superpowers inside Claude Code:"
    echo "    /plugin install superpowers@claude-plugins-official"
else
    echo ""
    echo "  Claude Code not found — skipping."
fi

# ══ Cursor ════════════════════════════════════════════════════════════════════

if [ -d "$CURSOR_DIR" ]; then
    echo ""
    echo "▶ Cursor — installing karpathy rule"
    echo ""

    RULES_DIR="$CURSOR_DIR/rules"
    download \
        "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/.cursor/rules/karpathy-guidelines.mdc" \
        "$RULES_DIR/karpathy-guidelines.mdc"
    echo "  [OK] karpathy-guidelines  →  $RULES_DIR/karpathy-guidelines.mdc"

    echo ""
    echo "  Next steps for Cursor:"
    echo "    Superpowers : /add-plugin superpowers  (inside Cursor)"
    echo "    gstack      : cd ~/gstack && ./setup --host cursor"
    echo "                  (clone first: git clone --depth 1 https://github.com/garrytan/gstack ~/gstack)"
fi

# ══ Other platforms ═══════════════════════════════════════════════════════════

if [ ${#detected_others[@]} -gt 0 ]; then
    echo ""
    echo "▶ Other platforms detected"
    echo ""
    echo "  karpathy-guidelines: paste the content of karpathy-guidelines/SKILL.md"
    echo "  into your platform's system instructions file (AGENTS.md, GEMINI.md, etc.)"
    echo ""

    for name in "${detected_others[@]}"; do
        echo "  ── $name"
        echo "     Superpowers : ${OTHER_SUPERPOWERS[$name]}"
        echo "     gstack      : ./setup --host ${OTHER_HOSTS[$name]}"
        echo ""
    done

    echo "  gstack clone (if not already done):"
    echo "    git clone --single-branch --depth 1 https://github.com/garrytan/gstack ~/gstack"
fi

echo ""
echo "Done."
