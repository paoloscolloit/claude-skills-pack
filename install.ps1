# Claude Skills Pack — Windows installer
# Installa: design-shotgun, canary, careful, guard (gstack) + karpathy-guidelines

$ErrorActionPreference = "Stop"
$skillsDir = "$env:USERPROFILE\.claude\skills"

Write-Host "Claude Skills Pack — installazione in corso..."
Write-Host "Directory: $skillsDir"
Write-Host ""

# Struttura delle skill da scaricare
$skills = @(
    @{
        name = "design-shotgun"
        files = @(
            @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/design-shotgun/SKILL.md"; dest = "SKILL.md" }
        )
    },
    @{
        name = "canary"
        files = @(
            @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/canary/SKILL.md"; dest = "SKILL.md" }
        )
    },
    @{
        name = "careful"
        files = @(
            @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/careful/SKILL.md"; dest = "SKILL.md" }
            @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/careful/bin/check-careful.sh"; dest = "bin\check-careful.sh" }
        )
    },
    @{
        name = "guard"
        files = @(
            @{ url = "https://raw.githubusercontent.com/garrytan/gstack/main/guard/SKILL.md"; dest = "SKILL.md" }
        )
    },
    @{
        name = "karpathy-guidelines"
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
Write-Host "Installazione completata."
Write-Host "Ricorda: per le skill Superpowers, esegui in Claude Code:"
Write-Host "  /plugin install superpowers@claude-plugins-official"
