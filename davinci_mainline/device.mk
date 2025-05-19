#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_DEVICE_PATH := device/xiaomi/mi7150-mainline/davinci_mainline

# Inherit options from mainline/qcom-common
## SoC
TARGET_QCOM_SOC := sm7150-aa
## TODO: Bringup the corresponding hardware and remove the following definitions
TARGET_AUDIO_HAL := default-aidl
TARGET_SUPPORTS_SUSPEND := false
include device/mainline/qcom-common/optional/options.mk

# Inherit from parent
$(call inherit-product, device/xiaomi/mi7150-mainline/device.mk)

# Boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2340

# DSP
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(TARGET_DEVICE_PATH)/socinfo/,$(TARGET_COPY_OUT_VENDOR)/etc/hexagonrpcd-root/socinfo/) \
    $(call find-copy-subdir-files,*,vendor/xiaomi/davinci/proprietary/vendor/etc/acdbdata/,$(TARGET_COPY_OUT_VENDOR)/etc/hexagonrpcd-root/acdb/) \
    $(call find-copy-subdir-files,*,vendor/xiaomi/davinci/proprietary/vendor/etc/sensors/config/,$(TARGET_COPY_OUT_VENDOR)/etc/hexagonrpcd-root/sensors/config/) \
    vendor/xiaomi/davinci/proprietary/vendor/etc/sensors/sns_reg_config:$(TARGET_COPY_OUT_VENDOR)/etc/hexagonrpcd-root/sensors/sns_reg.conf

# Firmware
PRODUCT_COPY_FILES += \
    vendor/xiaomi/davinci/proprietary/vendor/firmware/a615_zap.elf:$(TARGET_COPY_OUT_ODM)/firmware/qcom/sm7150/davinci/a615_zap.mbn

PRODUCT_PACKAGES += \
    all_symlink_firmware_davinci \
    firmware_davinci_ipa_fws.mbn

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
