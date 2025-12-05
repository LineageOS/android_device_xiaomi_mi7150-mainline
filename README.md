# Android device tree for Xiaomi devices with SM7150 SoC running mainline kernel

## Before flashing the Android build

1. Erase dtbo partition: `fastboot erase dtbo`
2. Flash the appropriate U-Boot build from [here](https://github.com/sm7150-mainline/u-boot/releases) to boot partition.

## Additional repositories required to build

| Path | Source |
|------|--------|
| kernel/xiaomi/mi7150-mainline | https://github.com/sm7150-mainline/linux (branch: `v6.19`) |
| vendor/xiaomi/davinci | https://wiki.lineageos.org/devices/davinci/build/variant1/#extract-proprietary-blobs |

## Kernel patches

| Commit name | Purpose | Source |
|-------------|---------|--------|
| `ANDROID: usb: gadget: configfs: Add Uevent to notify userspace` | Fixes USB in normal mode | https://android.googlesource.com/kernel/common-patches/+/refs/heads/main-kernel/android-mainline/ANDROID-usb-gadget-configfs-Add-Uevent-to-notify-userspace.patch |
| `Revert "staging: remove ashmem"` | Fixes media codec | https://android.googlesource.com/kernel/common-patches/+/refs/heads/main-kernel/android-mainline/Revert-staging-remove-ashmem.patch |
| `Revert "dm: fix copying after src array boundaries"` | Fixes kernel crash during APEX mount on 6.15 | `git revert f1aff4bc199cb92c055668caed65505e3b4d2656` |
| `Revert "dm: always update the array size in realloc_argv on success"` | Fixes kernel crash during APEX mount on 6.15 | `git revert 5a2a6c428190f945c5cbf5791f72dbea83e97f66` |
