import '../bean/device_info_android.dart';
import '../bean/device_info_ios.dart';
import '../bean/package_info.dart';
import './sing_plugin_tools_platform_interface.dart';

class SingPluginTools {
  Future<String?> getAndroidID() {
    return SingPluginToolsPlatform.instance.getAndroidID();
  }

  Future<String?> getAndroidImei() {
    return SingPluginToolsPlatform.instance.getAndroidImei();
  }

  Future<String?> requestPhoneState() {
    return SingPluginToolsPlatform.instance.requestPhoneState();
  }

  Future<String?> getAndroidOaid() {
    return SingPluginToolsPlatform.instance.getAndroidOaid();
  }

  Future<String?> getIosIdfa() {
    return SingPluginToolsPlatform.instance.getIosIdfa();
  }

  Future<PackageInfo> getPackageInfo() {
    return SingPluginToolsPlatform.instance.getPackageInfo();
  }

  Future<DeviceInfoAndroid> getDeviceInfoAndroid() {
    return SingPluginToolsPlatform.instance.getDeviceInfoAndroid();
  }

  Future<DeviceInfoIos> getDeviceInfoIos() {
    return SingPluginToolsPlatform.instance.getDeviceInfoIos();
  }
}
