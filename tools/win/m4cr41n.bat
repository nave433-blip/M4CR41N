@echo off
rem m4cr41n Windows launcher (cmd). Finds nvs.exe and runs the CLI.
setlocal
set "HERE=%~dp0"
if defined NVS_RUNTIME (
  "%NVS_RUNTIME%" run "%HERE%m4cr41n.nvs" %*
  exit /b %ERRORLEVEL%
)
where nvs.exe >nul 2>nul
if %ERRORLEVEL%==0 (
  nvs.exe run "%HERE%m4cr41n.nvs" %*
  exit /b %ERRORLEVEL%
)
if exist "%HERE%tools\nvs.exe" (
  "%HERE%tools\nvs.exe" run "%HERE%m4cr41n.nvs" %*
  exit /b %ERRORLEVEL%
)
echo m4cr41n: nvs.exe not found. Set NVS_RUNTIME or put nvs.exe on PATH. 1>&2
echo See docs\WINDOWS.md for the Windows setup. 1>&2
exit /b 2
