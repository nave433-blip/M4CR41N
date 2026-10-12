# m4cr41n Windows launcher (PowerShell).
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$candidates = @()
if ($env:NVS_RUNTIME) { $candidates += $env:NVS_RUNTIME }
$candidates += "nvs.exe"
$candidates += (Join-Path $here "tools\nvs.exe")
$nvs = $candidates | Where-Object { $_ -and (Test-Path $_ -PathType Leaf) } | Select-Object -First 1
if (-not $nvs) {
  try { $nvs = (Get-Command nvs.exe -ErrorAction Stop).Source } catch {}
}
if (-not $nvs) {
  Write-Error "m4cr41n: nvs.exe not found. Set `$env:NVS_RUNTIME or put nvs.exe on PATH. See docs/WINDOWS.md."
  exit 2
}
& $nvs run (Join-Path $here "m4cr41n.nvs") @args
exit $LASTEXITCODE
