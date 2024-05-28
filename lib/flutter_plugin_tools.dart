import 'flutter_plugin_tools_platform_interface.dart';

class FlutterPluginTools {
  Future<String?> getAndroidID() {
    return FlutterPluginToolsPlatform.instance.getAndroidID();
  }
  Future<String?> getAndroidImei() {
    return FlutterPluginToolsPlatform.instance.getAndroidImei();
  }
  Future<String?> requestPhoneState() {
    return FlutterPluginToolsPlatform.instance.requestPhoneState();
  }
  Future<String?> getAndroidOaid() {
    return FlutterPluginToolsPlatform.instance.getAndroidOaid();
  }
  Future<String?> getIosIdfa() {
    return FlutterPluginToolsPlatform.instance.getIosIdfa();
  }
}
