param(
    [switch]$PullOnly
)

$ErrorActionPreference = "Stop"

function Write-Step([string]$Message) {
    Write-Host ""
    Write-Host "== $Message ==" -ForegroundColor Cyan
}

function Ensure-Success {
    param(
        [int]$Code,
        [string]$Message
    )

    if ($Code -ne 0) {
        throw $Message
    }
}

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git was not found. Please install Git first."
}

$branch = (git branch --show-current).Trim()
if ([string]::IsNullOrWhiteSpace($branch)) {
    throw "No active Git branch was detected in this folder."
}

Write-Step "Check remote updates"
git fetch origin
Ensure-Success $LASTEXITCODE "Failed to fetch remote updates."

$statusLines = @(git status --porcelain)

if ($PullOnly -and $statusLines.Count -gt 0) {
    throw "Local changes were detected. Please use the full sync script, or commit your changes first."
}

if (-not $PullOnly -and $statusLines.Count -gt 0) {
    $defaultMessage = "Sync update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $commitMessage = Read-Host "Enter a commit message, or press Enter to use: $defaultMessage"
    if ([string]::IsNullOrWhiteSpace($commitMessage)) {
        $commitMessage = $defaultMessage
    }

    Write-Step "Save local changes"
    git add .
    Ensure-Success $LASTEXITCODE "Failed to stage local changes."

    git commit -m $commitMessage
    Ensure-Success $LASTEXITCODE "Failed to commit local changes."
} elseif (-not $PullOnly) {
    Write-Step "No local changes detected"
}

Write-Step "Sync remote changes"
git pull --rebase origin $branch
Ensure-Success $LASTEXITCODE "Failed to pull remote updates. Please resolve conflicts and try again."

if (-not $PullOnly) {
    Write-Step "Push to GitHub"
    git push origin $branch
    Ensure-Success $LASTEXITCODE "Failed to push to GitHub."
}

Write-Step "Done"
git status --short
Write-Host "Current branch: $branch" -ForegroundColor Green
if ($PullOnly) {
    Write-Host "Pull completed." -ForegroundColor Green
} else {
    Write-Host "Sync completed." -ForegroundColor Green
}
