# TWRP standart device files for Samsung Exynos SoC (Only Teegris v4 for now)
This device tree is incomplete and needs heavy modifications. Interested developers can contribute and request for fork and pull. Its main goal is providing File Based Encryption/Full Disk Encryption support in TWRP for Samsung devices with Exynos Processors.
Additional info: Samsung devices use tzdaemon to communicate with TEEgris. You need to manually add keystore, gatekeeper and tzdaemon related files to your vendor directory, add import flags to BoardConfig.mk and create vendor.prop with # Crypto info included.

# CURRENT STATE: TEMPLATE(incomplete)
