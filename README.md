# 1. Check environmental value

There is comment in [microfactory.bash](https://github.com/LineageOS/android_build_soong/blob/8fab12443ff40601/scripts/microfactory.bash#L17-L21)
```
# Inputs:
#  ${TOP}: The top of the android source tree
#  ${OUT_DIR}: The output directory location (defaults to ${TOP}/out)
#  ${OUT_DIR_COMMON_BASE}: Change the default out directory to
#    ${OUT_DIR_COMMON_BASE}/$(basename ${TOP})
```
To avoid what "soong" makes panic, it is good idea to eliminate setting of OUT_DIR_COMMON_BASE from .bashrc.

# 2. Check version of TWRP
Note that the TWRP version that allows you to install ROMs using adb sideload is <span style="color: red; ">TWRP 3.7.1</span>.<br>

# 3. Local_Manefest
The following typical local manifests are available for the branch of android17.

For the remove-project name block, you will need to customize it for different types of rom.<br>
```
<?xml version="1.0" encoding="UTF-8"?>
<!--Please do not manually edit this file-->
<manifest>
  <remote name="BrightTwikling"  fetch="https://github.com/BrightTwikling" />
  <remote name="LineageOS2"      fetch="https://github.com/LineageOS" />
  <remote name="crdroidandroid2" fetch="https://github.com/crdroidandroid" />

  <!-- remove-project name -->
  <remove-project name="LineageOS/android_hardware_qcom_audio"  />
  <remove-project name="LineageOS/android_hardware_qcom_audio-ar"  />
  <remove-project name="LineageOS/android_hardware_qcom_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_media"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_display-core"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_display-intf"  />
  <remove-project name="crdroidandroid/android_hardware_qcom_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_sdm845_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm7250_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm8150_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sdm845_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm7250_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm8150_display"  />
  <remove-project name="platform/platform_testing"  />

  <!-- Main repository -->
  <project path="device/asus/zenfone7"             name="android_device_asus_zenfone7"  remote="BrightTwikling" revision="lineage-23"      />
  <project path="kernel/asus/sm8250"               name="omnirom_kernel_asus_sm8250"    remote="BrightTwikling" revision="android-16"        />
  <project path="hardware/qcom-caf/sm8250/display" name="omnirom_hardware_qcom_display" remote="BrightTwikling" revision="android-15-sm8250" />
  <project path="platform_testing"                 name="android_platform_testing"      remote="BrightTwikling" revision="android-16-qpr2"   />

  <!-- packages/apps/Matlog -->
  <project path="packages/apps/Matlog"             name="android_packages_apps_Matlog"  remote="crdroidandroid2" revision="15.0"              />
</manifest>
```
