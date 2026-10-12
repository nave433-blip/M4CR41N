# M4CR41N on Windows

## Install (recommended)
From an Administrator-or-not PowerShell (no admin needed):
```powershell
cd tools\win
powershell -ExecutionPolicy Bypass -File install.ps1
```
This copies `nvs.exe`, the launchers, `m4cr41n.nvs` and `lib\` to
`%LOCALAPPDATA%\m4cr41n`, adds it to your **user** PATH, and verifies with
`m4cr41n version`. Open a **new** terminal afterwards, then run
`m4cr41n doctor`. Custom location:
`install.ps1 -InstallDir C:\tools\m4cr41n`.
Uninstall: `powershell -ExecutionPolicy Bypass -File "%LOCALAPPDATA%\m4cr41n\uninstall.ps1"`.

## Portable setup (no install)
1. Use the bundled runtime: `tools\win\nvs.exe` (cross-compiled from NvS 2.1.0),
   or install your own `nvs.exe` on PATH / set `NVS_RUNTIME`.
2. Launchers: `tools\win\m4cr41n.bat` (cmd) or `tools\win\m4cr41n.ps1` (PowerShell).
3. Install Apple device tools: `m4cr41n.bat doctor` prints what's missing.
   libimobiledevice has community Windows builds — install one and add it
   to PATH so `ideviceinfo`, `idevice_id`, `irecovery` resolve.
4. Apple USB driver: iTunes from Apple's site (not the Microsoft Store
   build) installs the Apple Mobile Device USB driver dfu/recovery
   detection needs.

## What works on Windows
- `devices`, `info`, `battery` (via libimobiledevice Windows build)
- `recovery enter` / `recovery exit`
- `dfu detect` (USB VID_05AC PID scan; PowerShell fallback if
  libimobiledevice is absent), `dfu guide`
- `firmware ...` (pure network, fully portable)
- `doctor`, `jailbreak check` (detection only)
- `apps`, `shot`, `restart`, `pair`, `backup info` (via libimobiledevice
  Windows build, when installed)
- Full NvS test suite: `tests\run_tests.bat [nvs.exe]`

## Release package contents (Windows zip)
Flat layout — the launchers and installer resolve it automatically:
```
m4cr41n-<ver>-windows\
  nvs.exe  m4cr41n.bat  m4cr41n.ps1  install.ps1  uninstall.ps1
  m4cr41n.nvs  lib\*.nvs  README.txt  WINDOWS.txt
```

## Windows limitations
- `nvram` and `secaudit` are macOS-only by nature (Apple firmware variables,
  csrutil/fdesetup). On Windows they print a clear notice, not a crash.
  Equivalent Windows checklist: verify Secure Boot + BitLocker + Defender
  tamper protection in Settings.
- `nvs.exe` here is cross-compiled and build-verified but was never
  executed on Windows — smoke-test on a real box (see PLACEHOLDERS.md).
- Interactive tools (palera1n CLI) must be run directly in your terminal;
  M4CR41N prints the exact command instead of trying to drive them.
