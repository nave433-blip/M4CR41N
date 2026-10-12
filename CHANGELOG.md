# M4CR41N progress log

## Unreleased — Wave 2 (draft release notes for v1.1.0)
- New commands: `apps list|find` (ideviceinstaller app inventory),
  `shot` (idevicescreenshot), `restart` (idevicediagnostics reboot),
  `pair list|validate` (idevicepair), `backup info` (idevicebackup2 —
  backup status + explicit encryption verdict).
- Jailbreak: expanded tool database — `jb_tools_for(ProductType, iOS)`
  recommends checkra1n (A5-A11, iOS 12-14.8.1), palera1n (A8-A11,
  iOS 15-16.7.x), or Dopamine (A12+, iOS 15-16.6.1); `jailbreak check`
  now prints per-device recommendations with install hints.
- CLI UX: unknown commands get a "did you mean" suggestion
  (Levenshtein-based, pure `suggest_command`); help lists new commands.
- secaudit: +2 checks — firewall stealth mode, automatic updates (7 total).
- Windows: proper installer — `tools/win/install.ps1` (copies payload to
  %LOCALAPPDATA%\m4cr41n, adds user PATH, verifies `m4cr41n version`) and
  `uninstall.ps1`; `tools/win/nvs.exe` rebuilt from NvS Wave 21
  (evaluator perf fixes included).
- Tests: 6/6 suites green (new tests/test_wave2.nvs: app-list parsing,
  version-range matching, tool DB, suggestions, tool hints).
- NOTE: Gemini CLI still quota-blocked (free tier, 20 req/day, 429);
  Wave 2 is solo senior review. The installer/launchers are parse-reviewed
  but need a real Windows box for execution testing (see PLACEHOLDERS.md).

## 2026-10-12 — refinement rounds 1-3 (post-v1.0.0)
Senior-review pass over every module; all changes tested (5/5 suites green).
- device: fixed macOS DFU/recovery misclassification — system_profiler PIDs
  ("0x1227") never matched classify_pid; new norm_pid() normalizes all
  backends (0x-strip + lowercase), wired into classify_pid and the
  linux/windows extractors.
- device: battery_health now prints a battery-key summary first
  (CycleCount/DesignCapacity/FullChargeCapacity/...), raw 60-line dump only
  as fallback; pure battery_summary_lines() is unit-tested.
- modes: dfu_guide is model-aware — new pure dfu_section_for() maps family
  names and ProductTypes (iPhone9,x -> 7 section, <=8,x -> home-button),
  prints the matching section first; CLI `dfu guide [model]` auto-detects
  the model from a connected device.
- nvram: shell-injection hardening — is_safe_nvram_name() allow-list on
  get/set/delete, shell_quote() on set values (new core.nvs helpers).
- ipsw: case-insensitive device lookup via pure ipsw_match_device()
  (null-safe); cmd_firmware fuzzy logic simplified to "no comma -> lookup".
- jailbreak: corrected SoC comments (iPhone8,x=A9, iPhone9,x=A10).
- core: added missing idevicescreenshot install hint.
- tools/win: fixed m4cr41n.bat/.ps1 path resolution — they pointed at
  tools\win\m4cr41n.nvs (nonexistent); now resolve repo layout and flat
  release-zip layout, with NVS_RUNTIME / beside-launcher / PATH fallback.
- tests: fixed dead t_parse_nvram() (defined, never called); ~40 new
  assertions across test_core/modes/device/ipsw/jailbreak.
- NOTE: Gemini CLI refinement loop could not run — Evan's API key is
  free-tier and quota-exhausted (20 req/day, 429). All improvements above
  are from direct senior review instead.

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
