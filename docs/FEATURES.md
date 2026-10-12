# M4CR41N feature map

Every command below is implemented and tested. No stubs.

| Command | Backend | Status |
|---|---|---|
| `doctor` | PATH probing + per-OS hints | working (Linux verified) |
| `devices` | `idevice_id -l` + UDID validation | working (Linux verified, no-device path) |
| `info [udid]` | `ideviceinfo` parsed dashboard | working (fixture-tested; live needs hardware) |
| `battery [udid]` | `idevicediagnostics` | working (no-device path verified) |
| `recovery enter [udid]` | `ideviceenterrecovery` | implemented (needs hardware) |
| `recovery exit` | `irecovery -n` / `-c reboot` | implemented (needs hardware) |
| `dfu detect` | USB PID scan (05ac:1227/1281) | working (Linux verified, no-device path) |
| `dfu guide` | knowledge base | working |
| `nvram dump/get/set/delete/boot-args` | macOS `nvram` | implemented (needs Mac) |
| `secaudit` | csrutil/fdesetup/spctl/socketfilterfw | implemented (needs Mac) |
| `firmware devices` | ipsw.me API | working (live-verified) |
| `firmware list <dev> [--signed]` | ipsw.me API | working (live-verified) |
| `firmware latest <dev>` | ipsw.me API | working (live-verified) |
| `jailbreak check [udid]` | ProductType+iOS → tool DB | working (unit-tested) |
| `jailbreak run [udid]` | launches user-installed tool | implemented (needs hardware + tool) |
| `apps list` / `apps find` | `ideviceinstaller -l` parsed | working (fixture-tested) |
| `shot [udid] [file]` | `idevicescreenshot` | implemented (needs hardware) |
| `restart [udid]` | `idevicediagnostics restart` | implemented (needs hardware) |
| `pair list` / `pair validate` | `idevicepair` | implemented (needs hardware) |
| `backup info [udid]` | `idevicebackup2 info` + encryption verdict | implemented (needs hardware) |
| `version` / `help` | — | working |

Competitor-inspired additions this release: unified device dashboard
(3uTools concept), firmware matching (3uTools/ipsw.me), guided DFU flows,
dependency doctor with install hints.
