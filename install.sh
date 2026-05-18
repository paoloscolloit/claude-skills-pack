#!/usr/bin/env bash
# Claude Skills Pack — Mac/Linux installer
# Installs: design-shotgun, canary, careful, guard (gstack) + karpathy-guidelines
#
# Claude Code: installs directly to ~/.claude/skills/
# Other platforms: detects installation and points to gstack setup script

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

detected_others=()

declare -A hosts=(
    ["Cursor"]="cursor:$HOME/.cursor"
    ["Codex CLI"]="codex:$HOME/.codex"
    ["OpenCode"]="opencode:$HOME/.config/opencode"
    ["Factory Droid"]="factory:$HOME/.factory"
    ["Slate"]="slate:$HOME/.slate"
    ["Kiro"]="kiro:$HOME/.kiro"
    ["Hermes"]="hermes:$HOME/.hermes"
    ["GBrain"]="gbrain:$HOME/.gbrain"
)

for name in "${!hosts[@]}"; do
    IFS=':' read -r host_flag host_dir <<< "${hosts[$name]}"
    if [ -d "$host_dir" ]; then
        detected_others+=("$host_flag")
    fi
done

# ── Claude Code install ───────────────────────────────────────────────────────

CLAUDE_DIR="$HOME/.claude"

if [ -d "$CLAUDE_DIR" ]; then
    SKILLS_DIR="$CLAUDE_DIR/skills"
    mkdir -p "$SKILLS_DIR"

    echo ""
    echo "Claude Code detected — installing to $SKILLS_DIR"
    echo ""

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
    echo "Claude Code: done."
    echo "Next step — install Superpowers inside Claude Code:"
    echo "  /plugin install superpowers@claude-plugins-official"
else
    echo ""
    echo "Claude Code not found — skipping."
fi

# ── Other platforms ───────────────────────────────────────────────────────────

if [ ${#detected_others[@]} -gt 0 ]; then
    echo ""
    echo "─────────────────────────────────────────────────────"
    echo "Other platforms detected."
    echo ""
    echo "gstack transforms skill files differently per platform"
    echo "(frontmatter, paths, metadata). Use gstack's own setup:"
    echo ""
    echo "  git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/gstack"
    echo "  cd ~/gstack"
    echo ""
    for host_flag in "${detected_others[@]}"; do
        echo "  ./setup --host $host_flag"
    done
    echo ""
    echo "─────────────────────────────────────────────────────"
fi

echo ""
echo "Done."
