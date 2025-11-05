/*
 * Copyright (C) 2025 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "vendor_init.h"

#include <libinit_dalvik_heap.h>
#include <libinit_utils.h>

static constexpr char[] kSerialFile = "/sys/devices/virtual/dmi/id/product_serial";
static constexpr char[] kSerialProp = "ro.serialno";

void vendor_load_properties() {
    set_dalvik_heap();
    set_prop_from_file(kSerialProp, kSerialFile);
}
