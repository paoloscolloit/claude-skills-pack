# Claude Skills Pack — Windows installer
#
# Per piattaforma:
#   Claude Code  → installa gstack skills + karpathy come SKILL.md
#   Cursor       → installa karpathy come .mdc rule; rimanda gstack a ./setup --host cursor
#   Altre        → stampa comandi manuali per Superpowers + gstack + karpathy

$ErrorActionPreference = "Stop"

# ── Helpers ───────────────────────────────────────────────────────────────────

function Download($url, $dest) {
    $folder = Split-Path $dest -Parent
    if (-not (Test-Path $folder)) { New-Item -ItemType Directory -Force -Path $folder | Out-Null }
    Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
}

# ── Platform detection ────────────────────────────────────────────────────────

$claudeDir  = "$env:USERPROFILE\.claude"
$cursorDir  = "$env:USERPROFILE\.cursor"

$others = [ordered]@{
    "Codex CLI"     = @{ dir = "$env:USERPROFILE\.codex";            host = "codex";    superpowers = "/plugins  →  select Superpowers  →  Install" }
    "OpenCode"      = @{ dir = "$env:USERPROFILE\.config\opencode";  host = "opencode"; superpowers = "(see https://github.com/obra/superpowers → .opencode/INSTALL.md)" }
    "Factory Droid" = @{ dir = "$env:USERPROFILE\.factory";          host = "factory";  superpowers = "droid plugin install superpowers@superpowers" }
    "Slate"         = @{ dir = "$env:USERPROFILE\.slate";            host = "slate";    superpowers = "(see gstack docs)" }
    "Kiro"          = @{ dir = "$env:USERPROFILE\.kiro";             host = "kiro";     superpowers = "(see gstack docs)" }
    "Hermes"        = @{ dir = "$env:USERPROFILE\.hermes";           host = "hermes";   superpowers = "(see gstack docs)" }
    "GBrain"        = @{ dir = "$env:USERPROFILE\.gbrain";           host = "gbrain";   superpowers = "(see gstack docs)" }
}

$detectedOthers = [ordered]@{}
foreach ($name in $others.Keys) {
    if (Test-Path $others[$name].dir) { $detectedOthers[$name] = $others[$name] }
}

# ══ Claude Code ═══════════════════════════════════════════════════════════════

if (Test-Path $claudeDir) {
    $skillsDir = "$claudeDir\skills"
    Write-Host ""
    Write-Host "▶ Claude Code — installing to $skillsDir"
    Write-Host ""

    $skills = @(
        @{ name = "design-shotgun";     url = "https://raw.githubusercontent.com/garrytan/gstack/main/design-shotgun/SKILL.md" },
        @{ name = "canary";             url = "https://raw.githubusercontent.com/garrytan/gstack/main/canary/SKILL.md" },
        @{ name = "guard";              url = "https://raw.githubusercontent.com/garrytan/gstack/main/guard/SKILL.md" },
        @{ name = "karpathy-guidelines";url = "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/karpathy-guidelines/SKILL.md" }
    )
    foreach ($s in $skills) {
        Download $s.url "$skillsDir\$($s.name)\SKILL.md"
        Write-Host "  [OK] $($s.name)"
    }

    # careful needs its hook script too
    Download "https://raw.githubusercontent.com/garrytan/gstack/main/careful/SKILL.md" "$skillsDir\careful\SKILL.md"
    Download "https://raw.githubusercontent.com/garrytan/gstack/main/careful/bin/check-careful.sh" "$skillsDir\careful\bin\check-careful.sh"
    Write-Host "  [OK] careful"

    Write-Host ""
    Write-Host "  Next: install Superpowers inside Claude Code:"
    Write-Host "    /plugin install superpowers@claude-plugins-official"
}
else {
    Write-Host ""
    Write-Host "  Claude Code not found — skipping."
}

# ══ Cursor ════════════════════════════════════════════════════════════════════

if (Test-Path $cursorDir) {
    Write-Host ""
    Write-Host "▶ Cursor — installing karpathy rule"
    Write-Host ""

    $rulesDir = "$cursorDir\rules"
    Download `
        "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/.cursor/rules/karpathy-guidelines.mdc" `
        "$rulesDir\karpathy-guidelines.mdc"
    Write-Host "  [OK] karpathy-guidelines  →  $rulesDir\karpathy-guidelines.mdc"

    Write-Host ""
    Write-Host "  Next steps for Cursor:"
    Write-Host "    Superpowers : /add-plugin superpowers  (inside Cursor)"
    Write-Host "    gstack      : cd ~/gstack && ./setup --host cursor"
    Write-Host "                  (clone first: git clone --depth 1 https://github.com/garrytan/gstack ~/gstack)"
}

# ══ Other platforms ═══════════════════════════════════════════════════════════

if ($detectedOthers.Count -gt 0) {
    Write-Host ""
    Write-Host "▶ Other platforms detected"
    Write-Host ""
    Write-Host "  karpathy-guidelines: paste the content of karpathy-guidelines/SKILL.md"
    Write-Host "  into your platform's system instructions file (AGENTS.md, GEMINI.md, etc.)"
    Write-Host ""

    foreach ($name in $detectedOthers.Keys) {
        $p = $detectedOthers[$name]
        Write-Host "  ── $name"
        Write-Host "     Superpowers : $($p.superpowers)"
        Write-Host "     gstack      : ./setup --host $($p.host)"
        Write-Host ""
    }

    Write-Host "  gstack clone (if not already done):"
    Write-Host "    git clone --single-branch --depth 1 https://github.com/garrytan/gstack ~/gstack"
}

Write-Host ""
Write-Host "Done."
