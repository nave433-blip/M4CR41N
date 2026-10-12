# M4CR41N competitor R&D (2026-10-12)

Domain: Apple iOS/macOS device management + security-research tooling.

## 1. libimobiledevice (LGPL-2.1 — invoke only, never link)
Open protocol implementation for Apple device comms. Killer utilities:
`ideviceinfo`, `idevice_id`, `ideviceenterrecovery`, `irecovery`,
`idevicediagnostics`, `idevicebackup2`, `idevicescreenshot`, `idevicepair`.
Ships via brew (macOS), apt (Linux), precompiled builds (Windows).
**Adopted as our device backend** — M4CR41N wraps these, never reimplements
the protocol. License note: we only shell out to the CLIs, so LGPL
contagion does not apply; flagged for Evan anyway.

## 2. 3uTools (closed source, Windows/macOS)
The reference all-in-one iOS toolbox. Killer features:
- Unified device dashboard: model, iOS, battery health + cycle count,
  storage, activation/jailbreak status at a glance
- One-click firmware matching + flash (normal/DFU/recovery)
- Backup/restore, SHSH backup, baseband up/down
- Jailbreak integration, ringtone maker, real-time monitoring
**Adopted (clean-room):** the dashboard concept (`m4cr41n info`),
firmware matching via ipsw.me (`m4cr41n firmware`), guided DFU flows.
Not copied: their flashing engine, proprietary drivers.

## 3. checkra1n / palera1n (open source, checkm8 bootrom exploit, A5–A11)
Permanent bootrom exploit → tethered jailbreaks for research. Killer
feature: unpatchable, works on A5–A11 regardless of iOS version.
**Adopted:** SoC vulnerability detection + launcher for the user's own
installed builds. We ship zero exploit code.

## 4. futurerestore + tsschecker (open source)
Restore to unsigned iOS with saved SHSH blobs; tsschecker saves blobs.
**Adopted:** install hints via `doctor`; launch guidance in docs.
Not reimplemented — these are deep, single-purpose tools.

## 5. ipsw.me (community API over Apple CDNs)
Public JSON API for signed-firmware metadata; download URLs point at
Apple's own servers. **Adopted directly** (`m4cr41n firmware ...`) —
this is the data backbone of our firmware commands.

## Deliberately NOT adopted
- Anything marketed as "iCloud bypass / MDM bypass / passcode bypass":
  theft-deterrent circumvention, out of scope (see SCOPE.md).
- iMazing-style paid backup explorers: no open equivalent worth cloning;
  `idevicebackup2` covers the CLI need.
