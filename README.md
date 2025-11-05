# Android device tree for Xiaomi devices with SM7150 SoC running mainline kernel

## Additional files required to build

| Path | Source |
|------|--------|
| device/xiaomi/mi7150-mainline/prebuilts/u-boot-sm7150-xiaomi-davinci.img | https://github.com/sm7150-mainline/u-boot/releases/download/2025-04-14/u-boot-sm7150-xiaomi-davinci-usb-peripheral.img |

## Additional repositories required to build

| Path | Source |
|------|--------|
| kernel/xiaomi/mi7150-mainline | https://github.com/sm7150-mainline/linux (branch: `v6.18`) |
| vendor/xiaomi/davinci | https://wiki.lineageos.org/devices/davinci/build/variant1/#extract-proprietary-blobs |

## Kernel patches

- `ANDROID: usb: gadget: configfs: Add Uevent to notify userspace` (Fixes USB in normal mode)
- `Revert "staging: remove ashmem"` (Fixes media codec)
- `Revert "dm: fix copying after src array boundaries"` (Fixes kernel crash during APEX mount on 6.15+)
- `Revert "dm: always update the array size in realloc_argv on success"` (Fixes kernel crash during APEX mount on 6.15+)
