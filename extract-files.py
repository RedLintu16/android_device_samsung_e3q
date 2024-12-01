#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    # FIXME
    'device/samsung/e3q',
    'hardware/samsung',
    'kernel/samsung/sm8650',
    'kernel/samsung/sm8650-modules',
    'hardware/qcom-caf/sm8650',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/commonsys-intf/display',
    'hardware/qcom-caf/sm8650/data-ipa-cfg-mgr',
    'vendor/qcom/opensource/dataservices',
    'hardware/qcom-caf/wlan',
    #'packages/apps/FMRadio/jni/fmr',
    #'frameworks/native/libs/vibrator',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libsecril-client'
    ): lib_fixup_vendor_suffix,
    (
        'libagmclient',
        'libpalclient',
        'libwpa_client',
    ): lib_fixup_remove,
}


blob_fixups: blob_fixups_user_type = {
    ('vendor/bin/hw/android.hardware.security.keymint-service-spu-qti', 'vendor/bin/hw/android.hardware.security.keymint-service', 'vendor/lib64/libhyper.so', 'vendor/lib64/libspukeymintdeviceutils.so', 'vendor/lib64/hw/gatekeeper.mdfpp.so', 'vendor/lib64/libcppcose_rkp.so', 'vendor/lib64/libspukeymint.so', 'vendor/lib64/libhermes.so', 'vendor/lib64/libese-grdg.so', 'vendor/lib64/libspukeymintutils.so', 'vendor/lib64/libskeymint10device.so', 'vendor/lib64/liblbs_core.so', 'vendor/lib64/liboemcrypto.so', 'vendor/lib64/libwifi-hal-qcom.so', 'vendor/lib64/libpuresoftkeymasterdevice.so', 'vendor/lib64/libpal_net_if.so', 'vendor/lib64/libsfp_sensor.so', 'vendor/lib64/libkeystore-engine-wifi-hidl.so', 'vendor/lib64/libkeymaster_portable.so', 'vendor/lib64/mediacas/libclearkeycasplugin.so', 'vendor/lib64/libqcc_sdk.so', 'vendor/lib64/libdk_vnd_service_core.so', 'vendor/lib64/libwifi-hal.so', 'vendor/lib64/libtlpd_crypto.so', 'vendor/lib64/libsec-ril.so', 'vendor/lib64/libcppbor_external.so', 'vendor/lib64/libucm_tlc_tz_esecomm.so', 'vendor/lib64/libqms.so', 'vendor/lib64/libskeymint_cli.so', 'vendor/lib64/libengmode15.so', 'vendor/lib64/libkeymaster4_1support.so', 'vendor/lib64/libizat_core.so', 'vendor/lib64/libspcom.so', 'vendor/lib64/libFaceService.so', 'vendor/lib64/uwb_uci.hal.so', 'vendor/lib64/libnicm_utils.so', 'vendor/lib64/mediadrm/libdrmclearkeyplugin.so', 'vendor/lib64/libkeymaster4support.so', 'vendor/lib64/libsdmextension.so'
): blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so')
        .replace_needed('libcppbor_external.so', 'libcppbor.so')
        .add_needed('android.hardware.security.rkp-V3-ndk.so')
}  # fmt: skip

module = ExtractUtilsModule(
    'e3q',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    check_elf=True
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
