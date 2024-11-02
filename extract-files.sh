#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=e3q
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

# If XML files don't have comments before the XML header, use this flag
# Can still be used with broken XML files by using blob_fixup
export TARGET_DISABLE_XML_FIXING=true

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_FIRMWARE=
KANG=
SECTION=
CARRIER_SKIP_FILES=()

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-firmware)
            ONLY_FIRMWARE=true
            ;;
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib64/libhyper.so|vendor/lib64/libspukeymintdeviceutils.so|vendor/lib64/hw/gatekeeper.mdfpp.so|vendor/lib64/libcppcose_rkp.so|vendor/lib64/libspukeymint.so|vendor/lib64/libhermes.so|vendor/lib64/libese-grdg.so|vendor/lib64/libspukeymintutils.so|vendor/lib64/libskeymint10device.so|vendor/lib64/liblbs_core.so|vendor/lib64/liboemcrypto.so|vendor/lib64/libwifi-hal-qcom.so|vendor/lib64/libpuresoftkeymasterdevice.so|vendor/lib64/libpal_net_if.so|vendor/lib64/libsfp_sensor.so|vendor/lib64/libkeystore-engine-wifi-hidl.so|vendor/lib64/libkeymaster_portable.so|vendor/lib64/mediacas/libclearkeycasplugin.so|vendor/lib64/libqcc_sdk.so|vendor/lib64/libdk_vnd_service_core.so|vendor/lib64/libwifi-hal.so|vendor/lib64/libtlpd_crypto.so|vendor/lib64/libsec-ril.so|vendor/lib64/libcppbor_external.so|vendor/lib64/libucm_tlc_tz_esecomm.so|vendor/lib64/libqms.so|vendor/lib64/libskeymint_cli.so|vendor/lib64/libengmode15.so|vendor/lib64/libkeymaster4_1support.so|vendor/lib64/libizat_core.so|vendor/lib64/libspcom.so|vendor/lib64/libFaceService.so|vendor/lib64/uwb_uci.hal.so|vendor/lib64/libnicm_utils.so|vendor/lib64/mediadrm/libdrmclearkeyplugin.so|vendor/lib64/libkeymaster4support.so|vendor/lib64/libsdmextension.so)
            [ "$2" = "" ] && return 0
            grep -q "android.hardware.security.rkp-V3-ndk.so" "${2}" || ${PATCHELF} --add-needed "android.hardware.security.rkp-V3-ndk.so" "${2}"
            ${PATCHELF} --replace-needed libcrypto.so libcrypto-v33.so "${2}"
            #${PATCHELF} --replace-needed libcppbor_external.so libcppbor.so "${2}"
            ;;
        vendor/lib64/hw/gatekeeper.mdfpp.so)
            [ "$2" = "" ] && return 0
            ${PATCHELF} --replace-needed libcrypto.so libcrypto-v33.so "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

if [ -z "${ONLY_FIRMWARE}" ]; then
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"
