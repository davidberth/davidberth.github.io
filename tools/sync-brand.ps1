<#
.SYNOPSIS
    Pull generated brand artifacts from the lixelbrand repo into this site.

.DESCRIPTION
    lixelbrand authors the identity; this repo consumes it. Nothing here is
    hand-drawn and nothing here is authoritative -- to change how the mark
    looks, edit lixelbrand/src/ and rebuild there, then re-run this.

    Copies are committed to this repo, so GitHub Actions builds the site with
    no sibling repo present and no image toolchain. A missing lixelbrand
    breaks re-syncing only, never deploying.

    Every file is verified against lixelbrand's MANIFEST.json before it is
    copied, so a half-built or hand-edited dist/ is caught here rather than
    shipped to lixel.io.

.PARAMETER BrandPath
    Path to the lixelbrand repo. Defaults to ..\lixelbrand -- the repos are
    siblings by convention, not by requirement.

.PARAMETER WhatIf
    Report what would change without writing anything.

.EXAMPLE
    .\tools\sync-brand.ps1
    .\tools\sync-brand.ps1 -BrandPath D:\src\lixelbrand -WhatIf
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$BrandPath = (Join-Path $PSScriptRoot '..\..\lixelbrand')
)

$ErrorActionPreference = 'Stop'

$repo  = Resolve-Path (Join-Path $PSScriptRoot '..')
$brand = try { Resolve-Path $BrandPath -ErrorAction Stop } catch {
    throw "lixelbrand not found at '$BrandPath'. Clone it beside this repo, or pass -BrandPath. (Syncing needs it; building the site does not.)"
}
$dist = Join-Path $brand 'dist'
if (-not (Test-Path $dist)) {
    throw "No dist/ in '$brand'. Run: python tools/build.py  (in lixelbrand)"
}

# --- verify dist/ against its own manifest -------------------------------
$manifestPath = Join-Path $dist 'MANIFEST.json'
if (-not (Test-Path $manifestPath)) { throw "Missing $manifestPath" }
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

$entries = @($manifest.files.PSObject.Properties)
$bad = @()
foreach ($entry in $entries) {
    $file = Join-Path $dist $entry.Name
    if (-not (Test-Path $file)) { $bad += "$($entry.Name) (missing)"; continue }
    $actual = (Get-FileHash $file -Algorithm SHA256).Hash.ToLower()
    if ($actual -ne $entry.Value) { $bad += "$($entry.Name) (hash mismatch)" }
}
if ($bad.Count) {
    throw ("lixelbrand dist/ does not match its MANIFEST:`n  " + ($bad -join "`n  ") +
           "`nRun: python tools/build.py  (in lixelbrand)")
}
Write-Host "verified $($entries.Count) files against MANIFEST (mark v$($manifest.mark_version), tokens v$($manifest.tokens_version))"

# --- what lands where ----------------------------------------------------
# Source names are lixelbrand's; destination names are what this site's
# markup expects. The mapping lives here because favicon naming is a
# web-platform concern, not a brand one.
$favicons = Join-Path $repo 'assets\img\favicons'
$map = @(
    @{ From = 'web\lixel-16.png';   To = "$favicons\favicon-16x16.png" }
    @{ From = 'web\lixel-32.png';   To = "$favicons\favicon-32x32.png" }
    @{ From = 'web\lixel-48.png';   To = "$favicons\favicon-48x48.png" }
    @{ From = 'web\lixel-96.png';   To = "$favicons\favicon-96x96.png" }
    @{ From = 'web\lixel-180.png';  To = "$favicons\apple-touch-icon.png" }
    @{ From = 'web\lixel-192.png';  To = "$favicons\web-app-manifest-192x192.png" }
    @{ From = 'web\lixel-512.png';  To = "$favicons\web-app-manifest-512x512.png" }
    @{ From = 'web\favicon.ico';    To = "$favicons\favicon.ico" }
    @{ From = 'logo\lixel-mark.svg'; To = "$favicons\favicon.svg" }
    @{ From = 'logo\lixel-mark.svg'; To = "$repo\assets\img\lixel-mark.svg" }
    @{ From = 'scss\_lixel-tokens.scss'; To = "$repo\_sass\_lixel-tokens.scss" }
)

$changed = 0
foreach ($m in $map) {
    $src = Join-Path $dist $m.From
    if (-not (Test-Path $src)) { throw "Expected artifact missing: $src" }

    $dstDir = Split-Path $m.To -Parent
    if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }

    $same = (Test-Path $m.To) -and
            ((Get-FileHash $src -Algorithm SHA256).Hash -eq (Get-FileHash $m.To -Algorithm SHA256).Hash)
    if ($same) { continue }

    $rel = $m.To.Substring($repo.Path.Length + 1)
    if ($PSCmdlet.ShouldProcess($rel, 'update from lixelbrand')) {
        Copy-Item $src $m.To -Force
    }
    Write-Host "  updated $rel"
    $changed++
}

if ($changed -eq 0) {
    Write-Host 'already up to date'
} else {
    Write-Host "$changed file(s) updated -- review and commit"
}
