# install.ps1
# Deploys /improve and /add-workflow commands to ~/.claude/commands/.
# Backs up existing files before overwriting.

param(
    [switch]$DryRun,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$CLAUDE_HOME = Join-Path $env:USERPROFILE '.claude'
$COMMANDS_DIR = Join-Path $CLAUDE_HOME 'commands'

function Step($msg) { Write-Host ""; Write-Host "==> $msg" -ForegroundColor Cyan }
function Info($msg) { Write-Host "    $msg" -ForegroundColor Gray }
function Warn($msg) { Write-Host "    ! $msg" -ForegroundColor Yellow }

Write-Host ""
Write-Host "Project Improvement Workflow — Installer" -ForegroundColor Green
Write-Host "========================================="
if ($DryRun) { Write-Host "MODE: dry-run (no changes)" -ForegroundColor Yellow }
Write-Host ""

# --- Sanity checks ---
Step "Sanity checks"

$src_commands = Join-Path $SCRIPT_DIR 'commands'
if (-not (Test-Path $src_commands)) {
    Write-Host "    X Cannot find $src_commands" -ForegroundColor Red
    exit 1
}
Info "Source files OK"

if (-not (Test-Path $CLAUDE_HOME)) {
    Warn "$CLAUDE_HOME does not exist. Will create."
    if (-not $DryRun) {
        New-Item -Path $CLAUDE_HOME -ItemType Directory -Force | Out-Null
    }
}

if (-not (Test-Path $COMMANDS_DIR)) {
    Info "Creating $COMMANDS_DIR"
    if (-not $DryRun) {
        New-Item -Path $COMMANDS_DIR -ItemType Directory -Force | Out-Null
    }
}

# --- Deploy commands ---
Step "Deploy slash commands"

$commands = @('improve.md', 'add-workflow.md')

foreach ($c in $commands) {
    $src = Join-Path $src_commands $c
    $dst = Join-Path $COMMANDS_DIR $c

    if (Test-Path $dst) {
        if (-not $Force) {
            Warn "$c already exists — skipping (use -Force to overwrite)"
            continue
        }
        # Backup existing
        $backup = "$dst.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        if (-not $DryRun) {
            Copy-Item -Path $dst -Destination $backup -Force
            Info "Backed up existing $c → $(Split-Path $backup -Leaf)"
        } else {
            Info "[dry-run] would backup $c"
        }
    }

    if (-not $DryRun) {
        Copy-Item -Path $src -Destination $dst -Force
        Info "Installed $c"
    } else {
        Info "[dry-run] would install $c"
    }
}

# --- Done ---
Step "Done"
Write-Host ""
Write-Host "Installed commands:" -ForegroundColor Green
Write-Host "  /improve         — audit and improve any project" -ForegroundColor White
Write-Host "  /add-workflow    — add workflow files to existing project" -ForegroundColor White
Write-Host ""
Write-Host "Optional plugins for deeper reviews:" -ForegroundColor Gray
Write-Host "  /plugin install github.com/EveryInc/compound-engineering-plugin" -ForegroundColor Gray
Write-Host "  /plugin install github.com/garrytan/gstack" -ForegroundColor Gray
Write-Host ""
Write-Host "Usage: open any project in Claude Code and run /improve" -ForegroundColor White
Write-Host ""
