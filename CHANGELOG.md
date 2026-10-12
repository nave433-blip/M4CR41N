# M4CR41N progress log

## 2026-10-12 — v1.0.0: repo built from empty README to working toolkit
- Repo was README-only (2 commits, zero code). All claimed features were missing.
- Built the full toolkit in NvS: `m4cr41n.nvs` CLI + 8 lib modules
  (core, device, modes, nvram, secaudit, ipsw, doctor, jailbreak).
- Commands: doctor, devices, info, battery, recovery enter/exit, dfu detect/guide,
  nvram dump/get/set/delete/boot-args, secaudit, firmware devices/list/latest,
  jailbreak check/run, version, help.
- Live-verified: `firmware latest/list` against the real ipsw.me API
  (iPhone10,1 → iOS 16.7.16 signed, Apple CDN URL).
- `doctor` verified against real apt-installed libimobiledevice-utils;
  found+fixed UDID validation bug (idevice_id error text misread as UDID).
- `m4cr41n.nave` workflow entry works (delegates to CLI doctor check).
- Tests: 5 NvS test files, all passing (run_tests.sh).
- NvS parser quirks documented in code comments (bare `return` after other
  statements in a block; `;`-separated statements on one line; no array `+`).
- Windows port: `tools/win/nvs.exe` cross-compiled (GOOS=windows, 12MB),
  `m4cr41n.bat` + `m4cr41n.ps1` launchers, `run_tests.bat`, docs/WINDOWS.md.
  exe build-verified, never executed on Windows (placeholder).
- Scope boundary set in SCOPE.md: no iCloud/MDM/passcode bypass, ever.
- License: MIT.
