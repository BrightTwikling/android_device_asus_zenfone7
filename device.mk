# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2019-2025 The OmniRom Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

DEVICE_PACKAGE_OVERLAYS += \
    device/asus/zenfone7/omni/CarrierConfig

PRODUCT_PACKAGES += \
    FrameworksResOverlay \
    FrameworksResVendorOverlay \
    OmniRomResInternalOverlay \
    SettingsOverlay_zenfone7 \
    SettingsProviderOverlay \
    SystemUIOverlay_zenfone7 \
    TetheringConfigOverlay \
    WifiOverlay

# A/B
AB_OTA_UPDATER := true

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS=false

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Additional apps
PRODUCT_PACKAGES += \
    MatLog \

# /system_ext packages
PRODUCT_PACKAGES += \
    Provision \
    WallpaperCropper

# Additional tools
PRODUCT_PACKAGES += \
    e2fsck \
    mkfs.exfat \
    fsck.exfat \
    mke2fs \
    tune2fs

# Api
BOARD_SHIPPING_API_LEVEL := 29
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@6.0-impl \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.3-impl \
    audio.primary.kona \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    tinymix \
    sound_trigger.primary.kona

PRODUCT_PACKAGES += \
    liba2dpoffload \
    libbatterylistener \
    libhdmiedid \
    libhfp \
    libsndmonitor

PRODUCT_PACKAGES += \
    libqcomvoiceprocessing

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects_ZS670KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS670KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_ZS670KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes_ZS670KS.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes_ZS670KS.xml

# Bluetooth(AIDL)
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl

# Bluetooth(HIDL)
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0 \
    android.hardware.bluetooth@1.0.vendor \
    audio.bluetooth.default \
    vendor.qti.hardware.bluetooth_audio@2.1.vendor \
    vendor.qti.hardware.btconfigstore@1.0.vendor \
    vendor.qti.hardware.btconfigstore@2.0.vendor

PRODUCT_COPY_FILES +=\
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

$(call soong_config_set_bool,QTI_GPT_UTILS,USE_BSG_FRAMEWORK,false)

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    CameraTile

$(call soong_config_set_bool,camera,camera_needs_client_info,true)

# Cas
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2

# Charger
PRODUCT_PACKAGES += \
    libsuspend

# Additional native libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Config
ifneq ($(wildcard packages/apps/SimpleDeviceConfig/Android.bp),)
PRODUCT_PACKAGES += \
    SimpleDeviceConfig
endif

ifneq ($(wildcard packages/apps/SimpleSettingsConfig/Android.bp),)
PRODUCT_PACKAGES += \
    SimpleSettingsConfig
endif

# Configstore
PRODUCT_PACKAGES += \
    disable_configstore

# editor for config
ifneq ($(wildcard external/vim/Android.bp),)
PRODUCT_PACKAGES += \
    vim
endif

# DeviceParts
PRODUCT_PACKAGES += \
    DeviceParts

# Crypto
PRODUCT_PACKAGES += \
    libcrypto-v33

#  IPACM
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    libipanat \
    liboffloadhal

# Network
PRODUCT_PACKAGES += \
    librmnetctl \
    libnetfilter_conntrack \
    libnfnetlink

# Device Assertion
TARGET_OTA_ASSERT_DEVICE := I002D, WW_I002D, ASUS_I002D

# DexAdd
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify

PRODUCT_PRODUCT_PROPERTIES += \
    dalvik.vm.dex2oat-Xmx=1024m \
    dalvik.vm.image-dex2oat-Xmx=256m \
    pm.dexopt.boot=verify \
    pm.dexopt.first-boot=verify \
    pm.dexopt.install=speed-profile \
    dalvik.vm.image-dex2oat-filter=speed \
    dalvik.vm.image-dex2oat-threads=8 \
    dalvik.vm.dex2oat-filter=speed \
    dalvik.vm.dex2oat-threads=8 \
    dalvik.vm.dex2oat64.enabled=true

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    android.hardware.renderscript@1.0-impl \
    gralloc.qcom \
    libion \
    libtinyalsa \
    libtinyxml2 \
    libqdutils \
    libqservice \
    libsdmcore \
    libsdmutils \
    libvulkan \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.memtrack-service \
    libcrypto_shim \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxG711Enc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVenc \
    android.frameworks.displayservice@1.0 \
    vendor.display.color@1.0 \
    vendor.display.color@1.1 \
    vendor.display.color@1.2 \
    vendor.display.color@1.3 \
    vendor.display.color@1.4 \
    vendor.display.color@1.5 \
    vendor.display.config@2.0 \
    vendor.display.postproc@1.0 \
    vendor.qti.hardware.display.composer@3.0 \

-include hardware/qcom-caf/sm8250/display/config/display-board.mk

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey \
    libcrypto_shim.vendor

# Exclude vibrator from InputManager
PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service

# FM
BOARD_HAVE_QCOM_FM := true
ifeq ($(BOARD_HAVE_QCOM_FM),true)
PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio
endif

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0 \
    android.hardware.gnss@1.1 \
    android.hardware.gnss@2.0 \
    android.hardware.gnss@2.1

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@3.0 \
    android.hardware.graphics.composer@2.1 \
    android.hardware.graphics.composer@2.2 \
    android.hardware.graphics.composer@2.3 \
    android.hardware.graphics.composer@2.4
 
# Freeform MultiwindowAdd commentMore actions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# Health for charing control
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/device/smartchg_stop_charging)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/power_supply/battery/device/smartchg_slow_charging)
$(call soong_config_set,lineage_health,fast_charge_value_none,2)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,1)
$(call soong_config_set,lineage_health,fast_charge_value_super_fast_charge,0)

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor \
    android.hidl.allocator@1.0 \
    android.hidl.base@1.0

# Input
PRODUCT_PACKAGES += \
    fts_ts.idc

PRODUCT_PACKAGES += \
    keylayout_data_zenfone7.kl

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.lineage

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    librs_jni

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0 \
    android.hardware.media.omx@1.0

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2.xml \
    $(LOCAL_PATH)/media/media_codecs_kona.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_kona.xml \
    $(LOCAL_PATH)/media/media_codecs_performance_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_c2.xml \
    $(LOCAL_PATH)/media/media_codecs_performance_kona.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance_kona.xml

# Monitoring, Scheduler, and Statistics
PRODUCT_PACKAGES += \
    android.frameworks.displayservice@1.0 \
    android.frameworks.sensorservice@1.0 \
    android.frameworks.stats@1.0

# Mount Point symlinks
PRODUCT_PACKAGES += \
    mnt_point_asusfw_symlink \
    mnt_point_factory_symlink \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint \
    COUNTRY_symlink

# Netutils
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0 \
    libandroid_net

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2-service \
    $(RELEASE_PACKAGE_NFC_STACK) \
    Tag \
    SecureElement \
    com.android.nfc_extras \
    android.hardware.nfc@1.0 \
    android.hardware.nfc@1.1 \
    android.hardware.nfc@1.2

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.lineage-libperfmgr

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Prebuilt
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/asus/zenfone7/prebuilt/product,product) \
    $(call find-copy-subdir-files,*,device/asus/zenfone7/prebuilt/system,system) \
    $(call find-copy-subdir-files,*,device/asus/zenfone7/prebuilt/system_ext,system_ext) \
    $(call find-copy-subdir-files,*,device/asus/zenfone7/prebuilt/root,recovery/root) \
    $(call find-copy-subdir-files,*,device/asus/zenfone7/prebuilt/vendor,vendor)

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat \
    libprotobuf-cpp-lite-vendorcompat

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.asus \
    fstab.qcom \
    fstab.qcom.ramdisk

# Security
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0 \
    android.hardware.gatekeeper@1.0 \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.keymaster@4.0

# Security(Additional)
PRODUCT_PACKAGES += \
    AxSandbox \
    AppLocker

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml

# RIL
PRODUCT_PACKAGES += \
    android.hardware.radio-service.compat \
    android.hardware.secure_element@1.2 \
    android.hardware.secure_element@1.2.vendor \
    libjsoncpp.vendor \
    libsqlite.vendor

# Shims
PRODUCT_PACKAGES += \
    libgui_shim

# Soundtrigger
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.2 \
    android.hardware.soundtrigger@2.2-impl

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel

# Soong namespaces
power_libperfmgr_soong := $(wildcard hardware/*/interfaces/power-libperfmgr)
PRODUCT_SOONG_NAMESPACES += \
    $(power_libperfmgr_soong)

# Systemhelper
PRODUCT_PACKAGES += \
    vendor.qti.hardware.systemhelper@1.0

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    qti-telephony-utils-prd \
    qti_telephony_utils_prd.xml

# Telephony extension
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf

PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti

# Update engine
PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_HOST_PACKAGES += \
    brillo_update_payload

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# Vendor service
PRODUCT_PACKAGES += \
    com.qualcomm.qti.dpm.api@1.0 \
    vendor.qti.data.factory@2.0 \
    vendor.qti.data.factory@2.1 \
    vendor.qti.esepowermanager@1.0 \
    vendor.qti.esepowermanager@1.1 \
    vendor.qti.hardware.alarm@1.0 \
    vendor.qti.hardware.audiohalext@1.0 \
    vendor.qti.hardware.bluetooth_sar@1.0 \
    vendor.qti.hardware.cacert@1.0 \
    vendor.qti.hardware.camera.postproc@1.0 \
    vendor.qti.hardware.capabilityconfigstore@1.0 \
    vendor.qti.hardware.data.connection@1.0 \
    vendor.qti.hardware.data.connection@1.1 \
    vendor.qti.hardware.data.iwlan@1.0 \
    vendor.qti.hardware.display.composer@3.0 \
    vendor.qti.hardware.dsp@1.0 \
    vendor.qti.hardware.qccvndhal@1.0 \
    vendor.qti.hardware.qseecom@1.0 \
    vendor.qti.hardware.qteeconnector@1.0 \
    vendor.qti.hardware.sensorscalibrate@1.0 \
    vendor.qti.hardware.slmadapter@1.0 \
    vendor.qti.hardware.soter@1.0 \
    vendor.qti.hardware.trustedui@1.0 \
    vendor.qti.hardware.tui_comm@1.0 \
    vendor.qti.hardware.vpp@1.1 \
    vendor.qti.hardware.vpp@1.2 \
    vendor.qti.hardware.vpp@1.3 \
    vendor.qti.ims.callinfo@1.0 \
    vendor.qti.ims.factory@1.0 \
    vendor.qti.imsrtpservice@3.0

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwifi-hal-qcom \
    wpa_supplicant \
    wpa_supplicant.conf \
    libcld80211

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink

# others
PRODUCT_PACKAGES += \
    vendor.qti.hardware.capabilityconfigstore@1.0 \
    vendor.qti.hardware.slmadapter@1.0 \
    vendor.qti.hardware.tui_comm@1.0 \
    vendor.qti.hardware.trustedui@1.0 \
    vendor.qti.hardware.soter@1.0 \
    vendor.qti.hardware.vpp@1.1 \
    vendor.qti.hardware.vpp@1.2 \
    vendor.qti.hardware.vpp@1.3

# Inherit from vendor blobs
$(call inherit-product, vendor/asus/zenfone7/zenfone7-vendor.mk)
