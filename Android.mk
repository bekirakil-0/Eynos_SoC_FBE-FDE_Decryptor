LOCAL_PATH := $(call my-dir)

ifeq ($(BOARD_USES_EXYNOS_FBE_DECRYPTION),true)
    BOARD_USES_EXYNOS_DECRYPTION := true

    # Dummy file to apply post-install patch for exynos_decrypt_fbe
    include $(CLEAR_VARS)

    LOCAL_MODULE := exynos_decrypt_fbe
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/system/bin
    LOCAL_REQUIRED_MODULES := exynos_decrypt

    # Cannot send to TARGET_RECOVERY_ROOT_OUT since build system wipes init*.rc
    # during ramdisk creation and only allows init.recovery.*.rc files to be copied
    # from TARGET_ROOT_OUT thereafter
    LOCAL_POST_INSTALL_CMD += \
        cp -f $(LOCAL_PATH)/FDE/init.recovery* $(TARGET_ROOT_OUT); \
        bash $(LOCAL_PATH)/scripts/service_cleanup.bash;
    include $(BUILD_PHONY_PACKAGE)
endif

ifeq ($(BOARD_USES_EXYNOS_DECRYPTION),true)
    # Dummy file to apply post-install patch for exynos_decrypt
    include $(CLEAR_VARS)

    LOCAL_MODULE := exynos_decrypt
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_CLASS := ETC
    LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/system/bin
    LOCAL_REQUIRED_MODULES := relink_binaries relink_libraries resetprop twrp_ramdisk

    # Cannot send to TARGET_RECOVERY_ROOT_OUT since build system wipes init*.rc
    # during ramdisk creation and only allows init.recovery.*.rc files to be copied
    # from TARGET_ROOT_OUT thereafter
    LOCAL_POST_INSTALL_CMD += \
        if [ -e $(TARGET_ROOT_OUT)/init.recovery.exynos2100.rc ]; then \
        grep -qF 'init.recovery.exynos_decrypt.rc' $(TARGET_ROOT_OUT)/init.recovery.exynos2100.rc || \
        echo -e '\nimport /init.recovery.exynos_decrypt.rc' >> $(TARGET_ROOT_OUT)/init.recovery.exynos2100.rc; \
        elif [ -e $(TARGET_RECOVERY_ROOT_OUT)/init.recovery.exynos2100.rc ]; then \
        grep -qF 'init.recovery.exynos_decrypt.rc' $(TARGET_RECOVERY_ROOT_OUT)/init.recovery.exynos2100.rc || \
        echo -e '\nimport /init.recovery.exynos_decrypt.rc' >> $(TARGET_RECOVERY_ROOT_OUT)/init.recovery.exynos2100.rc; \
        elif [ -e device/$(shell echo $(PRODUCT_BRAND) | tr  '[:upper:]' '[:lower:]')/$(TARGET_DEVICE)/recovery/root/init.recovery.exynos2100.rc ]; then \
        grep -qF 'init.recovery.exynos_decrypt.rc' device/$(shell echo $(PRODUCT_BRAND) | tr  '[:upper:]' '[:lower:]')/$(TARGET_DEVICE)/recovery/root/init.recovery.exynos2100.rc || \
        echo -e '\nimport /init.recovery.exynos_decrypt.rc' >> device/$(shell echo $(PRODUCT_BRAND) | tr  '[:upper:]' '[:lower:]')/$(TARGET_DEVICE)/recovery/root/init.recovery.exynos2100.rc; \
        else echo -e '\n*** init.recovery.exynos2100.rc not found ***\nYou will need to manually add the import for init.recovery.exynos_decrypt.rc to your init.recovery.(ro.hardware).rc file!!\n'; fi; \
        cp -Ra $(LOCAL_PATH)/crypto/system $(TARGET_ROOT_OUT)/;

    ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS),true)
        LOCAL_POST_INSTALL_CMD += \
            cp -f $(LOCAL_PATH)/FDE/init.recovery.exynos_decrypt.rc $(TARGET_ROOT_OUT)/;
    else
        LOCAL_POST_INSTALL_CMD += \
            cp -f $(LOCAL_PATH)/FDE/init.recovery.exynos_decrypt.rc $(TARGET_ROOT_OUT)/; \
            sed -i 's/on property:ro.crypto.state=encrypted && property:ro.boot.dynamic_partitions=true/on property:ro.crypto.state=encrypted/' $(TARGET_ROOT_OUT)/init.recovery.exynos_decrypt.rc;
    endif
    ifeq ($(BOARD_USES_EXYNOS_FBE_DECRYPTION),)
        LOCAL_POST_INSTALL_CMD += \
            bash $(LOCAL_PATH)/scripts/service_cleanup.bash;
    endif
    include $(BUILD_PHONY_PACKAGE)
endif
