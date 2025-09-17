ℹ️
* Your warranty is now void.
* I am not responsible for bricked devices, dead SD cards,
 thermonuclear war, or you getting fired because the alarm app failed.
* Please do some research if you have any concerns about doing this to your device
* YOU are choosing to make these modifications, and if
 you point the finger at me for messing up your device, I will laugh at you.
#

# TWRP standart device files for Samsung Exynos SoC (Only TEEgris v4 for now)
This device tree is incomplete and needs heavy modifications. Interested developers can contribute and request for fork and pull. Its main goal is providing File Based Encryption/Full Disk Encryption support in TWRP for Samsung devices with Exynos Processors.

𝐀𝐝𝐝𝐢𝐭𝐢𝐨𝐧𝐚𝐥 𝐢𝐧𝐟𝐨: Samsung devices use tzdaemon to communicate with TEEgris. You need to manually add keystore, gatekeeper and tzdaemon related files to your vendor directory, add import flags to BoardConfig.mk and create vendor.prop with # Crypto info included.

# CURRENT STATE: Test ❎ (Incomplete)

Changelog: 

#Sep 3, 2025
Fixed script but some files are still unlocated

#Aug 26, 2025
inital release

