# M4CR41N — Scope & Legal Boundary

M4CR41N is a **security-research and device-management toolkit** for Apple
hardware that the operator owns or is authorized to test. It consolidates
open, legitimate tooling (libimobiledevice, ipsw.me data, checkra1n/palera1n
launchers) behind one NvS CLI.

## In scope

- Device detection, identification, and info dashboards (own devices)
- Recovery-mode enter/exit, DFU-mode **detection** + guided entry
- macOS NVRAM read/write (operator's own Mac; SIP warnings shown)
- macOS security-posture auditing (SIP, FileVault, Gatekeeper, firewall)
- Signed-firmware metadata via the public ipsw.me API (Apple CDN links)
- checkm8-vulnerability detection + launching the user's own installed
  checkra1n/palera1n builds (open-source research tools; no exploit code ships here)
- Dependency checking with per-OS install guidance

## Explicitly OUT of scope — will not be built

- **iCloud Activation Lock bypass** (theft-deterrent circumvention)
- **MDM / DEP enrollment bypass**
- **Passcode brute-force or lock-screen bypass**
- Any exploit, payload, or circumvention code targeting Apple's
  theft-deterrent or access-control systems

These are deliberately excluded: they primarily enable use of lost or stolen
devices. "Bypass and activation tools" in the original README referred to
legitimate restore/activation workflows (idevicerestore, carrier activation
via standard tools) — not lock circumvention. If a future feature request
touches this boundary, it needs Evan's explicit, specific approval AND a
legitimate-research justification; the default answer is no.

## Operator responsibility

You are responsible for complying with local law and only using these tools
on hardware you own or are authorized to test. Jailbreaking and firmware
work can void warranties and brick devices — back up first.
