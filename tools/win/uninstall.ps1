# M4CR41N Windows uninstaller.
# Removes the install directory and takes it back off the user PATH.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File uninstall.ps1 [-InstallDir <path>]
param(
  [string]$InstallDir = (Join-Path $env:LOCALAPPDATA "m4cr41n")
)

$ErrorActionPreference = "Stop"

if (Test-Path $InstallDir -PathType Container) {
  Remove-Item $InstallDir -Recurse -Force
  Write-Host "[+] removed $InstallDir"
} else {
  Write-Host "[*] $InstallDir not present; nothing to remove."
}

$regPath = "HKCU:\Environment"
$cur = (Get-ItemProperty -Path $regPath -Name Path -ErrorAction SilentlyContinue).Path
if ($cur) {
  $parts = @($cur -split ";" | Where-Object { $_ -and ($_.TrimEnd("\") -ne $InstallDir.TrimEnd("\")) })
  $newPath = ($parts -join ";").Trim(";")
  if ($newPath -ne $cur) {
    Set-ItemProperty -Path $regPath -Name Path -Value $newPath
    Write-Host "[+] removed from user PATH."
  } else {
    Write-Host "[*] was not on user PATH."
  }
}

Write-Host "M4CR41N uninstalled. Restart your terminal to pick up the PATH change."
