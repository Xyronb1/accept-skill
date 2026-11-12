<#
.SYNOPSIS
    Installs the /accept skill into Claude Code (Windows).
.DESCRIPTION
    Copies the skill\accept folder of this repository into the target skills folder.
    If an "accept" skill already exists there, it is not deleted: it is moved to
    skills_backup\accept_<timestamp>, next to (outside of) the skills folder.
.PARAMETER Target
    Skills folder. Default: $HOME\.claude\skills
    For a single project use: <project>\.claude\skills
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target C:\code\myproj\.claude\skills
#>
[CmdletBinding()]
param(
    [string]$Target = (Join-Path $HOME '.claude\skills')
)

$ErrorActionPreference = 'Stop'

try {
    $source = Join-Path (Split-Path $PSScriptRoot -Parent) 'skill\accept'
    if (-not (Test-Path (Join-Path $source 'SKILL.md'))) {
        Write-Host "ERROR: Skill files not found: $source" -ForegroundColor Red
        Write-Host "Make sure you cloned or extracted the repository without changing its folder layout." -ForegroundColor Red
        exit 2
    }

    if (-not (Test-Path $Target)) {
        New-Item -ItemType Directory -Path $Target -Force | Out-Null
    }

    $targetSkill = Join-Path $Target 'accept'
    if (Test-Path $targetSkill) {
        # The backup goes OUTSIDE the skills folder; inside it Claude Code would load a second /accept.
        $backupRoot = Join-Path (Split-Path $Target -Parent) 'skills_backup'
        if (-not (Test-Path $backupRoot)) {
            New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
        }
        $backup = Join-Path $backupRoot ('accept_' + (Get-Date -Format 'yyyyMMdd_HHmmss'))
        Move-Item -Path $targetSkill -Destination $backup
        Write-Host "Previous installation backed up to: $backup" -ForegroundColor Yellow
    }

    Copy-Item -Path $source -Destination $targetSkill -Recurse

    if (-not (Test-Path (Join-Path $targetSkill 'SKILL.md'))) {
        Write-Host "ERROR: Could not verify the copy." -ForegroundColor Red
        exit 1
    }

    Write-Host "Installed: $targetSkill" -ForegroundColor Green
    Write-Host "Next: fill in context.md with your own details, restart Claude Code, then type /accept."
    exit 0
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
