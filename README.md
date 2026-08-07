# Android device tree for Xiaomi devices with SM7150 SoC running mainline kernel

## Before flashing the Android build

1. Erase dtbo partition: `fastboot erase dtbo`
2. Flash the appropriate U-Boot build from [here](https://github.com/sm7150-mainline/u-boot/releases) to boot partition.

## Additional repositories required to build

| Path | Source |
|------|--------|
| kernel/mainline/sm7150-mainline | https://github.com/sm7150-mainline/linux (branch: `v7.2`) |
| vendor/xiaomi/davinci | https://wiki.lineageos.org/devices/davinci/build/variant1/#extract-proprietary-blobs |

## Android platform patches

| Commit name | Purpose | Source |
|-------------|---------|--------|
| `jniClatCoordinator: Do not crash on BPF SELinux context mismatch` | Fixes booting on v7.2+ kernels | https://review.lineageos.org/c/LineageOS/android_packages_modules_Connectivity/+/494663 |

## Kernel edits

- After applying kernel patches specified below, on `mm/Kconfig`, on config option `MEMFD_ASHMEM_SHIM`, remove the dependency on `ASHMEM_C`.

## Kernel patches

| Commit name | Purpose | Source |
|-------------|---------|--------|
| `ANDROID: usb: gadget: configfs: Add Uevent to notify userspace` | Fixes USB in normal mode | https://android.googlesource.com/kernel/common-patches/+/refs/heads/main-kernel/android-mainline/ANDROID-usb-gadget-configfs-Add-Uevent-to-notify-userspace.patch |
| `ANDROID: mm/memfd-ashmem-shim: Introduce shim layer` | Fixes media codec | https://android.googlesource.com/kernel/common-patches/+/refs/heads/main-kernel/android-mainline/ANDROID-mm-memfd-ashmem-shim-Introduce-shim-layer.patch |
| `ANDROID: mm: shmem: Use memfd-ashmem-shim ioctl handler"` | Fixes media codec | https://android.googlesource.com/kernel/common-patches/+/refs/heads/main-kernel/android-mainline/ANDROID-mm-shmem-Use-memfd-ashmem-shim-ioctl-handler.patch |
