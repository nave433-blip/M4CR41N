# M4CR41N — Native Mac Chaos Engine

Apple-device security-research toolkit, implemented in **Navescript (NvS)**
and runnable on macOS, Linux, and Windows. One CLI consolidates the
day-to-day workflows of iOS device research: detection, info dashboards,
recovery/DFU handling, macOS NVRAM + security auditing, signed-firmware
lookups, and jailbreak-tool orchestration.

> Scope is deliberate: this is for hardware you own or are authorized to
> test. iCloud activation bypass, MDM bypass, and passcode bypass are
> explicitly out of scope — see [SCOPE.md](SCOPE.md).

## Quick start

1. Install the NvS runtime (`nvs` on PATH, or set `NVS_RUNTIME`).
   Build from source: `go build ./cmd/nvs` in the NvS repo.
2. Install device tools (optional but recommended): `./m4cr41n doctor`
   tells you exactly what's missing and how to install it per OS.
3. Run: `./m4cr41n help`

```sh
./m4cr41n doctor                 # environment + dependency check
./m4cr41n devices                # list attached iOS devices
./m4cr41n info                   # device dashboard (3uTools-style overview)
./m4cr41n dfu detect             # find DFU / recovery-mode devices over USB
./m4cr41n dfu guide              # button combos to enter DFU
./m4cr41n recovery enter         # reboot device into recovery mode
./m4cr41n recovery exit          # reboot out of recovery mode
./m4cr41n nvram dump             # macOS NVRAM variables
./m4cr41n secaudit               # macOS security posture (SIP, FileVault, ...)
./m4cr41n firmware latest iPhone10,1   # newest signed IPSW + Apple CDN URL
./m4cr41n jailbreak check        # checkm8-vulnerability detection
```

Windows: `tools\win\m4cr41n.bat help` (or `m4cr41n.ps1`); ships with a
cross-compiled `nvs.exe`. See [docs/WINDOWS.md](docs/WINDOWS.md).

Workflow entry (original interface): `nvs nave m4cr41n.nave` runs the
self-check workflow.

## Layout

```
m4cr41n            POSIX launcher
m4cr41n.nvs        CLI entry (command dispatch)
m4cr41n.nave       workflow-doc entry (runs doctor via the CLI)
lib/               tool modules (core, device, modes, nvram, secaudit,
                   ipsw, doctor, jailbreak) — all real NvS, no stubs
tools/win/         nvs.exe (cross-compiled) + .bat / .ps1 launchers
tests/             NvS test suite + run_tests.sh / run_tests.bat
docs/              FEATURES, WINDOWS, MACOS, COMPETITORS (R&D notes)
```

## Tests

```sh
./tests/run_tests.sh /path/to/nvs
```

## Author

Evan Shipley
