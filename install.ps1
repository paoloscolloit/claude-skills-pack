# Claude Skills Pack — Windows installer
# Installs: design-shotgun, canary, careful, guard (gstack) + karpathy-guidelines
#
# Claude Code: installs directly to ~/.claude/skills/
# Other platforms: detects installation and points to gstack setup script

$ErrorActionPreference = "Stop"

# ── Platform detection ────────────────────────────────────────────────────────

$platforms = @{
    "Cursor"       = @{ dir = "$env:USERPROFILE\.cursor";              host = "cursor"   }
    "Codex CLI"    = @{ dir = "$env:USERPROFILE\.codex";               host = "codex"    }
    "OpenCode"     = @{ dir = "$env:USERPROFILE\.config\opencode";     host = "opencode" }
    "Factory Droid"= @{ dir = "$env:USERPROFILE\.factory";             host = "factory"  }
    "Slate"        = @{ dir = "$env:USERPROFILE\.slate";               host = "slate"    }
    "Kiro"         = @{ dir = "$env:USERPROFILE\.kiro";                host = "kiro"     }
    "Hermes"       = @{ dir = "$env:USERPROFILE\.hermes";              host = "hermes"   }
    "GBrain"       = @{ dir = "$env:USERPROFILE\.gbrain";              host = "gbrain"   }
}

$detectedOthers = @()
foreach ($name in $platforms.Keys) {
    if (Test-Path $platforms[$name].dir) {
        $detectedOthers += $platforms[$name]
    }
}

# ── Claude Code install ───────────────────────────────────────────────────────

$claudeDir = "$env:USERPROFILE\.claude"

if (Test-Path $claudeDir) {
    $skillsDir = "$claudeDir\skills"
    Write-Host ""
    Write-Host "Claude Code detected — installing to $skillsDir"
    Write-Host ""

    $skills = @(
        @{
            name  = "design-shotgun"
            files = @(
                @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/design-shotgun/SKILL.md"; dest = "SKILL.md" }
            )
        },
        @{
            name  = "canary"
            files = @(
                @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/canary/SKILL.md"; dest = "SKILL.md" }
            )
        },
        @{
            name  = "careful"
            files = @(
                @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/careful/SKILL.md"; dest = "SKILL.md" }
                @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/careful/bin/check-careful.sh"; dest = "bin\check-careful.sh" }
            )
        },
        @{
            name  = "guard"
            files = @(
                @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/guard/SKILL.md"; dest = "SKILL.md" }
            )
        },
        @{
            name  = "karpathy-guidelines"
            files = @(
                @{ url = "https://raw.githubusercontent.com/multica-ai/andrej-karpathy-skills/main/skills/karpathy-guidelines/SKILL.md"; dest = "SKILL.md" }
            )
        }
    )

    foreach ($skill in $skills) {
        $skillDir = "$skillsDir\$($skill.name)"
        New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
        foreach ($file in $skill.files) {
            $destPath = "$skillDir\$($file.dest)"
            $destFolder = Split-Path $destPath -Parent
            if (-not (Test-Path $destFolder)) {
                New-Item -ItemType Directory -Force -Path $destFolder | Out-Null
            }
            Invoke-WebRequest -Uri $file.url -OutFile $destPath -UseBasicParsing
        }
        Write-Host "  [OK] $($skill.name)"
    }

    Write-Host ""
    Write-Host "Claude Code: done."
    Write-Host "Next step — install Superpowers inside Claude Code:"
    Write-Host "  /plugin install superpowers@claude-plugins-official"
} else {
    Write-Host ""
    Write-Host "Claude Code not found — skipping."
}

# ── Other platforms ───────────────────────────────────────────────────────────

if ($detectedOthers.Count -gt 0) {
    Write-Host ""
    Write-Host "─────────────────────────────────────────────────────"
    Write-Host "Other platforms detected."
    Write-Host ""
    Write-Host "gstack transforms skill files differently per platform"
    Write-Host "(frontmatter, paths, metadata). Use gstack's own setup:"
    Write-Host ""
    Write-Host "  git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/gstack"
    Write-Host "  cd ~/gstack"
    Write-Host ""
    foreach ($p in $detectedOthers) {
        Write-Host "  ./setup --host $($p.host)"
    }
    Write-Host ""
    Write-Host "─────────────────────────────────────────────────────"
}

Write-Host ""
Write-Host "Done."
