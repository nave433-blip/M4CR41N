# M4CR41N Windows installer.
# Installs the toolkit to %LOCALAPPDATA%\m4cr41n (no admin needed),
# adds it to the user's PATH, and verifies with `m4cr41n version`.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File install.ps1 [-InstallDir <path>]
#
# Run from the tools\win directory of the repo, or from an extracted
# release zip (expects nvs.exe, m4cr41n.bat, m4cr41n.ps1 beside it, and
# m4cr41n.nvs + lib\ either beside it (zip layout) or at the repo root).
param(
  [string]$InstallDir = (Join-Path $env:LOCALAPPDATA "m4cr41n")
)

$ErrorActionPreference = "Stop"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

function Fail($msg) {
  Write-Error $msg
  exit 1
}

# ---- locate the payload ---------------------------------------------------
$nvsExe = Join-Path $here "nvs.exe"
if (-not (Test-Path $nvsExe -PathType Leaf)) {
  if ($env:NVS_RUNTIME -and (Test-Path $env:NVS_RUNTIME -PathType Leaf)) {
    $nvsExe = $env:NVS_RUNTIME
  } else {
    Fail "nvs.exe not found next to install.ps1. Run this from tools\win or an extracted release zip."
  }
}

# CLI script: flat layout (zip) first, then repo layout (tools\win -> root)
$cli = $null
$libDir = $null
foreach ($cand in @((Join-Path $here "m4cr41n.nvs"), (Join-Path $here "..\..\m4cr41n.nvs"))) {
  if (Test-Path $cand -PathType Leaf) {
    $cli = (Resolve-Path $cand).Path
    $libDir = Join-Path (Split-Path -Parent $cli) "lib"
    break
  }
}
if (-not $cli) { Fail "m4cr41n.nvs not found (looked beside install.ps1 and at the repo root)." }
if (-not (Test-Path $libDir -PathType Container)) { Fail "lib\ directory not found next to $cli" }

Write-Host "[*] installing M4CR41N to $InstallDir"

# ---- copy files ------------------------------------------------------------
$items = @(
  @{ Src = $nvsExe;                                    Dst = "nvs.exe" },
  @{ Src = (Join-Path $here "m4cr41n.bat");             Dst = "m4cr41n.bat" },
  @{ Src = (Join-Path $here "m4cr41n.ps1");             Dst = "m4cr41n.ps1" },
  @{ Src = $cli;                                       Dst = "m4cr41n.nvs" },
  @{ Src = (Join-Path $here "uninstall.ps1");          Dst = "uninstall.ps1" }
)
New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
foreach ($it in $items) {
  if (-not (Test-Path $it.Src -PathType Leaf)) { Fail ("missing payload file: " + $it.Src) }
  Copy-Item $it.Src (Join-Path $InstallDir $it.Dst) -Force
}
$dstLib = Join-Path $InstallDir "lib"
if (Test-Path $dstLib) { Remove-Item $dstLib -Recurse -Force }
Copy-Item $libDir $dstLib -Recurse -Force

# docs (best effort)
$rootDocs = Join-Path (Split-Path -Parent $cli) "docs\WINDOWS.md"
if (Test-Path $rootDocs -PathType Leaf) { Copy-Item $rootDocs (Join-Path $InstallDir "WINDOWS.txt") -Force }

# ---- PATH ------------------------------------------------------------------
# Add to the *user* PATH via the registry (no admin required).
$regPath = "HKCU:\Environment"
$cur = (Get-ItemProperty -Path $regPath -Name Path -ErrorAction SilentlyContinue).Path
if (-not $cur) { $cur = "" }
$parts = @($cur -split ";" | Where-Object { $_ -and ($_.TrimEnd("\") -ne $InstallDir.TrimEnd("\")) })
if ($parts -notcontains $InstallDir) {
  $newPath = (($parts + $InstallDir) -join ";").Trim(";")
  Set-ItemProperty -Path $regPath -Name Path -Value $newPath
  Write-Host "[+] added to user PATH: $InstallDir"
  # refresh this session too
  $env:Path = "$env:Path;$InstallDir"
} else {
  Write-Host "[*] already on user PATH."
}

# ---- verify ------------------------------------------------------------------
$launcher = Join-Path $InstallDir "m4cr41n.ps1"
Write-Host "[*] verifying install..."
$ver = & $launcher version 2>&1
if ($LASTEXITCODE -ne 0) { Fail "verification failed: $ver" }
Write-Host "[+] $ver"
Write-Host ""
Write-Host "M4CR41N installed. Open a NEW terminal and run:  m4cr41n doctor"
Write-Host "To uninstall:  powershell -ExecutionPolicy Bypass -File `"$InstallDir\uninstall.ps1`""
