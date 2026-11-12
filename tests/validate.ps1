<#
.SYNOPSIS
    Checks the structure of the /accept skill files (Windows PowerShell 5.1 and PowerShell 7).
.PARAMETER SkillDir
    Skill folder to check. Default: skill\accept in this repository.
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1 -SkillDir $HOME\.claude\skills\accept
#>
[CmdletBinding()]
param(
    [string]$SkillDir
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
if (-not $SkillDir) {
    $SkillDir = Join-Path $repoRoot 'skill\accept'
}
$script:fail = 0

function Test-Check([string]$Name, [bool]$Condition) {
    if ($Condition) {
        Write-Host ("[PASS] " + $Name) -ForegroundColor Green
    }
    else {
        Write-Host ("[FAIL] " + $Name) -ForegroundColor Red
        $script:fail++
    }
}

try {
    $skillMd = Join-Path $SkillDir 'SKILL.md'
    Test-Check "SKILL.md exists" (Test-Path $skillMd)
    if (-not (Test-Path $skillMd)) {
        Write-Host "SKILL.md is missing, remaining checks skipped." -ForegroundColor Red
        exit 1
    }

    $text = Get-Content -Raw -Encoding UTF8 $skillMd

    $frontmatter = ''
    if ($text -match '(?s)^---\s*\r?\n(.*?)\r?\n---') { $frontmatter = $Matches[1] }
    Test-Check "frontmatter present" ($frontmatter -ne '')
    Test-Check "name: accept" ($frontmatter -match '(?m)^name:\s*accept\s*$')
    Test-Check "disable-model-invocation: true" ($frontmatter -match '(?m)^disable-model-invocation:\s*true\s*$')

    $description = ''
    if ($frontmatter -match '(?m)^description:\s*(.+)$') { $description = $Matches[1] }
    Test-Check "description is set and at most 1024 characters" ($description.Length -gt 0 -and $description.Length -le 1024)

    Test-Check "contains `$ARGUMENTS" ($text -match '\$ARGUMENTS')
    Test-Check "flags section (## 0.) present" ($text -match '##\s*0\.')
    foreach ($flag in @('--prompt', '--ask', '--sor', '--en', '--tr')) {
        Test-Check ("flag documented: " + $flag) ($text -match [regex]::Escape('`' + $flag + '`'))
    }
    Test-Check "Language section present" ($text -match '(?m)^##\s*Language')
    Test-Check "Fixed rules section present" ($text -match '(?m)^##\s*Fixed rules')
    Test-Check "Flow section present" ($text -match '(?m)^##\s*Flow')
    Test-Check "What changed section present" ($text -match 'What changed')
    Test-Check "When you stop section present" ($text -match 'When you stop')
    Test-Check "context.md referenced" ($text -match 'context\.md')

    foreach ($ref in @('references\checklist.md', 'references\examples.md', 'templates\clarified-prompt.md', 'context.md')) {
        Test-Check ("file exists: " + $ref) (Test-Path (Join-Path $SkillDir $ref))
        $refName = ($ref -split '\\')[-1]
        if ($refName -ne 'context.md') {
            Test-Check ("SKILL.md references " + $refName) ($text -match [regex]::Escape($refName))
        }
    }

    $dirtyFiles = @()
    Get-ChildItem $SkillDir -Recurse -Filter *.md | ForEach-Object {
        $content = Get-Content -Raw -Encoding UTF8 $_.FullName
        if ([regex]::IsMatch($content, '[\x00-\x08\x0B\x0C\x0E-\x1F]')) { $dirtyFiles += $_.Name }
    }
    Test-Check "no control characters in .md files" ($dirtyFiles.Count -eq 0)

    # Repository-level files (skipped when validating an installed copy).
    if (-not $PSBoundParameters.ContainsKey('SkillDir')) {
        foreach ($f in @('prompts\universal-prompt.md', 'prompts\universal-prompt.tr.md', 'README.md', 'README.tr.md')) {
            Test-Check ("repo file exists: " + $f) (Test-Path (Join-Path $repoRoot $f))
        }
    }
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
if ($script:fail -eq 0) {
    Write-Host "ALL CHECKS PASSED." -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("$($script:fail) check(s) FAILED.") -ForegroundColor Red
    exit 1
}
