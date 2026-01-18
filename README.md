The following typical local manifests are available for the Lineage-22 branch.
For the remove-project name block, you will need to customize it for different types of rom.
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
  <remove-project name="LineageOS/android_vendor_qcom_opensource_agm"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_arpal-lx"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_audioreach-graphservices"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_data-ipa-cfg-mgr"  />
  <remove-project name="LineageOS/android_vendor_qcom_opensource_dataipa"  />
  <remove-project name="LineageOS/android_hardware_qcom_sdm845_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm7250_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm8150_gps"  />
  <remove-project name="LineageOS/android_hardware_qcom_sdm845_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm7250_display"  />
  <remove-project name="LineageOS/android_hardware_qcom_sm8150_display"  />
  <remove-project name="LineageOS/android_packages_services_Telephony"  />
  <remove-project name="LineageOS/android_hardware_qcom_data_ipacfg-mgr"  />

  <!-- Main repository -->
  <project path="device/asus/zenfone7"             name="android_device_asus_zenfone7"               remote="BrightTwikling"  revision="lineage-22"      />
  <project path="kernel/asus/sm8250"               name="omnirom_kernel_asus_sm8250"                 remote="BrightTwikling"  revision="android-15"        />
  <project path="hardware/qcom-caf/sm8250/display" name="omnirom_hardware_qcom_display"              remote="BrightTwikling"  revision="android-15-sm8250" />
  <project path="packages/services/Telephony"      name="Fork-LineageOS_packages_services_Telephony" remote="BrightTwikling"  revision="lineage-22.2" />

  <!-- packages/apps/Matlog -->
  <project path="packages/apps/Matlog"                           name="android_packages_apps_Matlog"                             remote="crdroidandroid2" revision="15.0"              />

</manifest>
```
