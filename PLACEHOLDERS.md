# PLACEHOLDERS.md — things needing Evan's hands / machines / decisions

## Needs a real Mac
- [ ] `nvram` commands (`dump/get/set/delete/boot-args`) — macOS-only; untested, no Mac on this VM.
- [ ] `secaudit` — reads csrutil/fdesetup/spctl; macOS-only, untested.
- [ ] `system_profiler SPUSBDataType` fallback in `usb_apple_devices()` — macOS-only path.
- [ ] checkra1n GUI launch path (`jb run` → checkra1n) — needs macOS/Linux + real device.

## Needs a real Windows machine
- [ ] `tools/win/nvs.exe` — cross-compiled (GOOS=windows), build verified, but never
      executed on Windows. Run `tests\run_tests.bat` there.
- [ ] `m4cr41n.bat` / `m4cr41n.ps1` launchers — untested on Windows.
- [ ] PowerShell Apple-USB fallback (`usb_apple_devices`) — quoting through
      `cmd /c` is best-effort; verify on a real box.
- [ ] libimobiledevice Windows build install flow — see docs/WINDOWS.md.

## Needs hardware (any OS)
- [ ] Any command touching a real iOS device (`info`, `battery`, `recovery`,
      `jailbreak`, DFU detect with a device in DFU) — no iOS hardware on this VM.
      All no-device paths are tested; with-device paths are code-reviewed only.

## Needs installs (not in repo)
- [ ] libimobiledevice suite (`doctor` tells you exactly what's missing + how).
- [ ] checkra1n / palera1n if you want `jailbreak run`.

## Decisions for Evan
- [ ] GitHub push of this work (standing rule: your explicit word each time).
- [ ] Whether to also ship prebuilt `nvs` binaries for macOS/Linux in `tools/`
      (currently only Windows ships one; POSIX users build from nvs-lang).
- [ ] libimobiledevice is LGPL-2.1: we only *invoke* its CLI tools (no linking),
      so there's no license contagion — but flagging per your sourcing rule.
