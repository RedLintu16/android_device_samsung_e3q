#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# API levels
BOARD_SHIPPING_API_LEVEL := 34
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    audioadsprpcd \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default \
    libagm_compress_plugin \
    libagm_mixer_plugin \
    libagm_pcm_plugin \
    libbatterylistener \
    libfmpal \
    libhfp_pal \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndcardparser \
    libtinycompress \
    libvolumelistener \
    sound_trigger.primary.pineapple \
    vendor.qti.hardware.pal@1.0.vendor \
    android.hardware.audio.common-V1-ndk \
    android.hardware.audio.common-V1-ndk.vendor

AUDIO_HAL_DIR := hardware/qcom-caf/sm8650/audio/primary-hal

PRODUCT_COPY_FILES += \
    $(AUDIO_HAL_DIR)/configs/common/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(AUDIO_HAL_DIR)/configs/pineapple/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_pineapple/audio_effects.conf \
    $(AUDIO_HAL_DIR)/configs/pineapple/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_pineapple/audio_effects.xml \
    $(AUDIO_HAL_DIR)/configs/pineapple/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 3120
TARGET_SCREEN_WIDTH := 1440

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    init.qti.display_boot.rc \
    init.qti.display_boot.sh \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.composer-service.rc \
    vendor.qti.hardware.display.composer-service.xml \
    vendor.qti.hardware.display.demura-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_3.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2022-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2022-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail.vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_ENFORCE_RRO_TARGETS := *

PRODUCT_PACKAGES += \
    CarrierConfigResCommon \
    FrameworksResCommon \
    FrameworksResSamsung \
    FrameworksResTarget \
    SettingsResSamsung \
    SystemUIResCommon \
    TelecommResCommon \
    TelephonyResCommon \
    WifiResCommon \
    WifiResTarget \
    WifiResTarget_spf

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti \
    libqti-perfd-client

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := phone

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat

# QMI
PRODUCT_PACKAGES += \
    libcurl.vendor \
    libjsoncpp.vendor \
    libqti_vndfwk_detect_vendor \
    libsqlite.vendor

# RIL
PRODUCT_PACKAGES += \
    libnetutils.vendor \
    libsecril-client \
    secril_config_svc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ril/sehradiomanager.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sehradiomanager.conf

# Rootdir
PRODUCT_PACKAGES += \
    dcc_extension.sh \
    hdm_status.sh \
    init.class_main.sh \
    init.crda.sh \
    init.kernel.post_boot-cliffs.sh \
    init.kernel.post_boot-pineapple.sh \
    init.kernel.post_boot.sh \
    init.mdm.sh \
    init.qcom.class_core.sh \
    init.qcom.coex.sh \
    init.qcom.early_boot.sh \
    init.qcom.efs.sync.sh \
    init.qcom.post_boot.sh \
    init.qcom.sdio.sh \
    init.qcom.sensors.sh \
    init.qcom.sh \
    init.qti.qcv.rc \
    init.qti.qcv.sh \
    init.qti.kernel.debug-cliffs.sh \
    init.qti.kernel.debug-pineapple.sh \
    init.qti.kernel.debug.sh \
    init.qti.kernel.early_debug-pineapple.sh \
    init.qti.kernel.early_debug.sh \
    init.qti.kernel.sh \
    init.qti.media.sh \
    init.qti.time.daemon.sh \
    init.qti.write.sh \
    init.vendor.sensordebug.sh \
    init.vendor.sensordebug.ssr_dump.sh \
    install-recovery.sh \
    qca6234-service.sh \
    system_dlkm_modprobe.sh \
    ueventd.qcom.rc \
    vendor_modprobe.sh \

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.e3q.rc \
    init.qcom.factory.rc \
    init.qcom.rc \
    init.qti.kernel.rc \
    init.qti.ss-ramdump.sh \
    init.qti.ufs.rc \
    init.samsung.bsp.rc \
    init.samsung.display.rc \
    init.samsung.dp.rc \
    init.samsung.factory.rc \
    init.samsung.power.rc \
    init.samsung.rc \
    init.samsung.user.rc \
    init.target.rc \
    init.recovery.qcom.rc \
    init.recovery.samsung.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.qcom

# Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/qcom-caf/common/libqti-perfd-client \
    hardware/samsung \
    kernel/samsung/sm8650 \
    kernel/samsung/sm8650-modules

# Telephony
PRODUCT_PACKAGES += \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    telephony-ext \
    android.hardware.radio.config-V2-ndk \
    libutilscallstack \
    libutilscallstack.vendor \
    android.hardware.radio.data-V2-ndk \
    android.hardware.radio.messaging-V2-ndk \
    android.hardware.radio.messaging-V2-ndk.vendor

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/vendor.samsung.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.mbms.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.mbms.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0.vendor

# Trusted UI
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti \
    init.qcom.usb.rc \
    init.qcom.usb.sh

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/usb/etc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# VNDK
PRODUCT_PACKAGES += \
    libcrypto-v33

# Wi-Fi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwpa_client \
    libwifi-hal-ctrl \
    libwifi-hal-qcom \
    wpa_supplicant \
    wpa_supplicant.conf \
    firmware_wlanmdsp.otaupdate_symlink \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    libpng \
    libpng.vendor \
    android.hardware.wifi.supplicant-V1-ndk \
    android.hardware.wifi.supplicant-V1-ndk.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# Keystore
PRODUCT_PACKAGES += \
android.system.keystore2-V1-ndk \
android.system.keystore2-V3-ndk \
libkeystore2 \
android.hardware.security.keymint-service \
libbinder_ndk \
libkeystore2_aaid \
libkeystore2_apc_compat \
libkeystore2_crypto \
libkm_compat_service \
libcppbor_external \
keystore2

# Bluetooth
PRODUCT_PACKAGES += \
android.hardware.bluetooth@1.0 \
android.hardware.bluetooth@1.0.vendor \
android.hardware.bluetooth@1.1 \
android.hardware.bluetooth@1.1.vendor \
android.hardware.bluetooth.audio@2.1 \
android.hardware.bluetooth.audio@2.0 \
android.hardware.bluetooth.audio@2.1.vendor \
android.hardware.bluetooth.audio@2.0.vendor \

# Gatekeeper
PRODUCT_PACKAGES += \
android.hardware.gatekeeper-V1-ndk \
android.hardware.gatekeeper-V1-ndk.vendor \
libgatekeeper \
libgatekeeper.vendor

# Libraries
PRODUCT_PACKAGES += \
libjson \
librmnetctl \

# GNSS
PRODUCT_PACKAGES += \
android.hardware.gnss-V3-ndk \
android.hardware.gnss-V2-ndk \
android.hardware.gnss-V1-ndk \
android.hardware.gnss-V3-ndk.vendor \
android.hardware.gnss-V2-ndk.vendor \
android.hardware.gnss-V1-ndk.vendor \

# Radio
PRODUCT_PACKAGES += \
android.hardware.radio.data-V2-ndk \
android.hardware.radio.data-V2-ndk.vendor

# Weaver
PRODUCT_PACKAGES += \
android.hardware.weaver@1.0 \
android.hardware.weaver@1.0.vendor

# Inherit the proprietary files
$(call inherit-product, vendor/samsung/e3q/e3q-vendor.mk)
