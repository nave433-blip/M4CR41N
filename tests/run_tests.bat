@echo off
rem M4CR41N test runner for Windows.
setlocal EnableDelayedExpansion
set "NVS=%~1"
if "%NVS%"=="" set "NVS=nvs.exe"
cd /d "%~dp0"
set PASS=0
set FAIL=0
for %%t in (test_*.nvs) do (
  "%NVS%" run "%%t" > "%TEMP%\m4cr41n-test.log" 2>&1
  if !ERRORLEVEL! EQU 0 (
    echo PASS %%t
    set /a PASS+=1
  ) else (
    echo FAIL %%t
    set /a FAIL+=1
  )
)
echo ----
echo passed: %PASS%  failed: %FAIL%
if %FAIL% NEQ 0 exit /b 1
