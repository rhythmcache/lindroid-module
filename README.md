# Lindroid Module for Project Infinity-X (AOSP / Android 17)

Flashable Magisk and KernelSU module for **Lindroid** built from **Project Infinity-X** (LineageOS 24 / Android 17) source tree.

## Included Components
- **LindroidUI**: Main Android container management and display application (`/system_ext/app/LindroidUI/LindroidUI.apk`)
- **Composer HAL**: `vendor.lindroid.composer-ndk.so` AIDL display composer interface (`/system_ext/lib64/`)
- **libjni_lindroidui**: JNI bindings connecting Android View/Surface stack with container graphics
- **perspectived**: Native container supervision and lifecycle daemon (`/system_ext/bin/perspectived`)
- **liblxc & tools**: Native LXC library and CLI tools (`lxc_start`, `lxc_stop`, `lxc_attach`, `lxc_info`, etc.)
- **IDC Profiles**: Input Device Configuration (`/system/usr/idc/Vendor_000a_Product_*.idc`) to prevent Lindroid input events from duplicating in host Android UI.

## CI Workflow
This repository contains a GitHub Actions workflow (`.github/workflows/build-infinityx-lindroid.yml`) that:
1. Selectively initializes and syncs core Project Infinity-X 17 build components.
2. Clones `vendor_lindroid`, `hardware_lindroid`, and `external_lxc`.
3. Applies Gerrit patch 12936 (`inputflinger: allow disabling input devices via idc`) to `frameworks/native`.
4. Compiles only the required modules via Soong (`m LindroidUI vendor.lindroid.composer-ndk perspectived liblxc lxc_*`).
5. Assembles and packages the compiled outputs as a flashable Magisk/KernelSU zip module.
