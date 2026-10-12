# M4CR41N on Windows

## Setup
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
- Full NvS test suite: `tests\run_tests.bat [nvs.exe]`

## Windows limitations
- `nvram` and `secaudit` are macOS-only by nature (Apple firmware variables,
  csrutil/fdesetup). On Windows they print a clear notice, not a crash.
  Equivalent Windows checklist: verify Secure Boot + BitLocker + Defender
  tamper protection in Settings.
- `nvs.exe` here is cross-compiled and build-verified but was never
  executed on Windows — smoke-test on a real box (see PLACEHOLDERS.md).
- Interactive tools (palera1n CLI) must be run directly in your terminal;
  M4CR41N prints the exact command instead of trying to drive them.
