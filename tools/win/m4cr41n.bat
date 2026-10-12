@echo off
rem m4cr41n Windows launcher (cmd). Finds nvs.exe and the m4cr41n.nvs CLI.
rem Works from the repo (tools\win\) and from the flat release zip.
setlocal
set "HERE=%~dp0"
rem locate the CLI script: repo layout first, then flat layout
set "SCRIPT="
if exist "%HERE%..\..\m4cr41n.nvs" set "SCRIPT=%HERE%..\..\m4cr41n.nvs"
if not defined SCRIPT if exist "%HERE%m4cr41n.nvs" set "SCRIPT=%HERE%m4cr41n.nvs"
if not defined SCRIPT (
  echo m4cr41n: could not find m4cr41n.nvs next to this launcher. 1>&2
  exit /b 2
)
rem locate the runtime: env override, beside the launcher, then PATH
set "NVS="
if defined NVS_RUNTIME set "NVS=%NVS_RUNTIME%"
if not defined NVS if exist "%HERE%nvs.exe" set "NVS=%HERE%nvs.exe"
if not defined NVS (
  where nvs.exe >nul 2>nul
  if %ERRORLEVEL%==0 set "NVS=nvs.exe"
)
if not defined NVS (
  echo m4cr41n: nvs.exe not found. Set NVS_RUNTIME or put nvs.exe on PATH. 1>&2
  echo See docs\WINDOWS.md for the Windows setup. 1>&2
  exit /b 2
)
"%NVS%" run "%SCRIPT%" %*
exit /b %ERRORLEVEL%
