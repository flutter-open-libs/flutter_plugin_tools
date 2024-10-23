import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import '../bean/package_info.dart';
import './sing_plugin_tools_method_channel.dart';

abstract class SingPluginToolsPlatform extends PlatformInterface {
  SingPluginToolsPlatform() : super(token: _token);

  static final Object _token = Object();

  static SingPluginToolsPlatform _instance = MethodChannelSingPluginTools();

  static SingPluginToolsPlatform get instance => _instance;

  static set instance(SingPluginToolsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getAndroidID() {
    throw UnimplementedError('getAndroidID() has not been implemented.');
  }

  Future<String?> getAndroidImei() {
    throw UnimplementedError('getAndroidImei() has not been implemented.');
  }

  Future<String?> requestPhoneState() {
    throw UnimplementedError('requestPhoneState() has not been implemented.');
  }

  Future<String?> getAndroidOaid() {
    throw UnimplementedError('getAndroidOaid() has not been implemented.');
  }

  Future<String?> getIosIdfa() {
    throw UnimplementedError('getIosIdfa() has not been implemented.');
  }

  Future<PackageInfo> getPackageInfo() {
    throw UnimplementedError('getPackageInfo() has not been implemented.');
  }
}
