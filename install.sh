#!/usr/bin/env bash
# Claude Skills Pack — Mac/Linux installer
# Installa: design-shotgun, canary, careful, guard (gstack) + karpathy-guidelines

set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
mkdir -p "$SKILLS_DIR"

echo "Claude Skills Pack — installazione in corso..."
echo "Directory: $SKILLS_DIR"
echo ""

download() {
    local url="$1"
    local dest="$2"
    mkdir -p "$(dirname "$dest")"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    else
        wget -q "$url" -O "$dest"
    fi
}

# design-shotgun
mkdir -p "$SKILLS_DIR/design-shotgun"
download \
    "https://raw.githubusercontent.com/garrytan/gstack/main/design-shotgun/SKILL.md" \
    "$SKILLS_DIR/design-shotgun/SKILL.md"
echo "  [OK] design-shotgun"

# canary
mkdir -p "$SKILLS_DIR/canary"
download \
    "https://raw.githubusercontent.com/garrytan/gstack/main/canary/SKILL.md" \
    "$SKILLS_DIR/canary/SKILL.md"
echo "  [OK] canary"

# careful + hook script
mkdir -p "$SKILLS_DIR/careful/bin"
download \
    "https://raw.githubusercontent.com/garrytan/gstack/main/careful/SKILL.md" \
    "$SKILLS_DIR/careful/SKILL.md"
download \
    "https://raw.githubusercontent.com/garrytan/gstack/main/careful/bin/check-careful.sh" \
    "$SKILLS_DIR/careful/bin/check-careful.sh"
chmod +x "$SKILLS_DIR/careful/bin/check-careful.sh"
echo "  [OK] careful"

# guard
mkdir -p "$SKILLS_DIR/guard"
download \
    "https://raw.githubusercontent.com/garrytan/gstack/main/guard/SKILL.md" \
    "$SKILLS_DIR/guard/SKILL.md"
echo "  [OK] guard"

# karpathy-guidelines
mkdir -p "$SKILLS_DIR/karpathy-guidelines"
download \
    "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/karpathy-guidelines/SKILL.md" \
    "$SKILLS_DIR/karpathy-guidelines/SKILL.md"
echo "  [OK] karpathy-guidelines"

echo ""
echo "Installazione completata."
echo "Ricorda: per le skill Superpowers, esegui in Claude Code:"
echo "  /plugin install superpowers@claude-plugins-official"
