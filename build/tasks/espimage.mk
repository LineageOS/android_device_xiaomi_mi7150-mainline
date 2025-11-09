#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(USES_DEVICE_XIAOMI_MI7150_MAINLINE),true)

BOOTMGR_TOOLS_BIN_DIR := prebuilts/bootmgr/tools/$(HOST_PREBUILT_TAG)/bin

GRUB_ARCH := arm64-efi
GRUB_BOOT_EFI_PREBUILT := device/virt/virtio_arm64/bootmgr/grub/prebuilt/boot/BOOTAA64.EFI
GRUB_CONFIGS := $(DEVICE_PATH)/misc/grub.cfg
GRUB_PREBUILT_DIR := prebuilts/bootmgr/grub/linux-arm64/$(GRUB_ARCH)

ESP_OUT_DIR := $(TARGET_OUT_INTERMEDIATES)/ESP

INSTALLED_ESPIMAGE_TARGET_INCLUDE_FILES := \
    $(PRODUCT_OUT)/boot.img \
    $(PRODUCT_OUT)/recovery.img \
    $(PRODUCT_OUT)/vendor_boot.img

INSTALLED_ESPIMAGE_TARGET_DEPS := \
    $(GRUB_BOOT_EFI_PREBUILT) \
    $(GRUB_CONFIGS) \
    $(INSTALLED_ESPIMAGE_TARGET_INCLUDE_FILES) \
    $(INSTALLED_KERNEL_TARGET)

# $(1): output file
# $(2): list of contents to include
# $(3): volume label
# $(4): image size in MB (optional)
define create-fat32image
	[ $(4) ] && [ $(4) -gt 0 ] && img_size=$(4) || \
		img_size=$$(python3 $(DEVICE_PATH)/build/tools/calc_fat32_img_size.py --label $(3) $(2)); \
		/bin/dd if=/dev/zero of=$(1) bs=1M count=$$img_size
	/sbin/mkfs.fat -n "$(3)" -F 32 -S 4096 $(1)
	$(foreach content,$(2),$(BOOTMGR_TOOLS_BIN_DIR)/mcopy -i $(1) -s $(content) :: &&)true
endef

define make-espimage-target
	$(hide) mkdir -p $(dir $(INSTALLED_ESPIMAGE_TARGET))
	$(call pretty,"Target EFI System Partition image: $(INSTALLED_ESPIMAGE_TARGET)")

	mkdir -p $(ESP_OUT_DIR)/EFI/BOOT $(ESP_OUT_DIR)/boot/grub/fonts

	cp -r $(GRUB_PREBUILT_DIR)/lib/grub/$(GRUB_ARCH) $(ESP_OUT_DIR)/boot/grub/
	cp $(GRUB_PREBUILT_DIR)/share/grub/unicode.pf2 $(ESP_OUT_DIR)/boot/grub/fonts/unicode.pf2

	cp $(GRUB_BOOT_EFI_PREBUILT) $(ESP_OUT_DIR)/EFI/BOOT/

	touch $(ESP_OUT_DIR)/boot/grub/.is_esp_part_on_android_boot_device

	cat $(GRUB_CONFIGS) > $(ESP_OUT_DIR)/boot/grub/grub.cfg

	mkdir -p $(ESP_OUT_DIR)/dtb/qcom/
	cp $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/arch/arm64/boot/dts/qcom/sm7150-xiaomi-*.dtb $(ESP_OUT_DIR)/dtb/qcom/

	$(call create-fat32image,$(INSTALLED_ESPIMAGE_TARGET),$(ESP_OUT_DIR)/* $(INSTALLED_ESPIMAGE_TARGET_INCLUDE_FILES),EFI)
endef

$(INSTALLED_ESPIMAGE_TARGET): $(INSTALLED_ESPIMAGE_TARGET_DEPS)
	$(call make-espimage-target)

.PHONY: espimage
espimage: $(INSTALLED_ESPIMAGE_TARGET)

.PHONY: espimage-nodeps
espimage-nodeps:
	@echo "make $(INSTALLED_ESPIMAGE_TARGET): ignoring dependencies"
	$(call make-espimage-target)

endif
