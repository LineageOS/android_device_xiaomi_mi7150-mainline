#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_DEVICE_PATH := device/xiaomi/mi7150-mainline/davinci_mainline

# Inherit options from mainline/qcom-common
## SoC
TARGET_QCOM_SOC := sm7150-aa
## TODO: Bringup the corresponding hardware and remove the following definitions
TARGET_HEALTH_HAL := cuttlefish
TARGET_SUPPORTS_SUSPEND := false
include device/mainline/qcom-common/optional/options.mk

# Inherit from parent
$(call inherit-product, device/xiaomi/mi7150-mainline/device.mk)

# Boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2340

# Firmware
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,external/firmware-xiaomi-davinci/lib/firmware/,$(TARGET_COPY_OUT_VENDOR)/firmware/)

# Init
PRODUCT_COPY_FILES += \
    $(TARGET_DEVICE_PATH)/fstab/fstab.davinci:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.davinci \
    $(TARGET_DEVICE_PATH)/init/init.davinci.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.davinci.rc

# Recovery
PRODUCT_COPY_FILES += \
    $(TARGET_DEVICE_PATH)/init/init.recovery.davinci.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.davinci.rc

# Vendor ramdisk
PRODUCT_COPY_FILES += \
    $(TARGET_DEVICE_PATH)/fstab/fstab.davinci:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.davinci
