# m4cr41n Windows launcher (PowerShell).
# Finds nvs.exe and the m4cr41n.nvs CLI.
# Works from the repo (tools\win\) and from the flat release zip.
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# locate the CLI script: repo layout first, then flat layout
$script = $null
foreach ($p in @((Join-Path $here "..\..\m4cr41n.nvs"), (Join-Path $here "m4cr41n.nvs"))) {
  if (Test-Path $p -PathType Leaf) { $script = $p; break }
}
if (-not $script) {
  Write-Error "m4cr41n: could not find m4cr41n.nvs next to this launcher."
  exit 2
}

# locate the runtime: env override, beside the launcher, then PATH
$nvs = $null
$candidates = @()
if ($env:NVS_RUNTIME) { $candidates += $env:NVS_RUNTIME }
$candidates += (Join-Path $here "nvs.exe")
foreach ($c in $candidates) {
  if ($c -and (Test-Path $c -PathType Leaf)) { $nvs = $c; break }
}
if (-not $nvs) {
  try { $nvs = (Get-Command nvs.exe -ErrorAction Stop).Source } catch {}
}
if (-not $nvs) {
  Write-Error "m4cr41n: nvs.exe not found. Set `$env:NVS_RUNTIME or put nvs.exe on PATH. See docs/WINDOWS.md."
  exit 2
}

& $nvs run $script @args
exit $LASTEXITCODE
