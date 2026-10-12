# M4CR41N on macOS

macOS is the primary target ("Native Mac" in the name).

## Setup
1. `brew install libimobiledevice` — device backend.
2. NvS runtime: build from the NvS repo (`go build ./cmd/nvs`) and put
   `nvs` on PATH, or set `NVS_RUNTIME`.
3. `./m4cr41n doctor` to verify.

## macOS-only commands
- `nvram dump|get|set|delete|boot-args` — firmware variables. Most writes
  need `sudo`; SIP blocks protected variables (boot-args included) unless
  SIP is partially/fully disabled — the tool warns, never silently fails.
- `secaudit` — SIP (`csrutil status`), FileVault (`fdesetup status`),
  Gatekeeper (`spctl --status`), firewall state, risky boot-args flags.
  Produces a PASS/FAIL scorecard.

## Notes
- DFU detection uses `system_profiler SPUSBDataType` as fallback when
  libimobiledevice is absent; with it installed, USB PIDs come from
  direct enumeration.
- checkra1n ships a macOS GUI build; `m4cr41n jailbreak run` launches it
  when installed.
- Untested on Apple Silicon vs Intel differences: USB enumeration and
  nvram behave the same; report quirks.
