import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sing_plugin_tools/utils/log_util.dart';
import '../bean/device_info_android.dart';
import '../bean/device_info_ios.dart';
import '../bean/package_info.dart';
import './sing_plugin_tools_platform_interface.dart';

class MethodChannelSingPluginTools extends SingPluginToolsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('sing.top/flutter_plugin_tools');

  @override
  Future<String?> getAndroidID() async {
    return await methodChannel.invokeMethod<String>('getAndroidID');
  }

  @override
  Future<String?> getAndroidImei() async {
    return await methodChannel.invokeMethod<String>('getAndroidImei');
  }

  @override
  Future<String?> requestPhoneState() async {
    return await methodChannel.invokeMethod<String>('requestPhoneState');
  }

  @override
  Future<String?> getAndroidOaid() async {
    return await methodChannel.invokeMethod<String>('getAndroidOaid');
  }

  @override
  Future<String?> getIosIdfa() async {
    return await methodChannel.invokeMethod<String>('getIosIdfa');
  }

  @override
  Future<PackageInfo> getPackageInfo() async {
    final map = await methodChannel.invokeMapMethod<String, dynamic>('getPackageInfo');
    return PackageInfo(
      appName: map!['appName'] ?? '',
      packageName: map['packageName'] ?? '',
      version: map['version'] ?? '',
      buildNumber: map['buildNumber'] ?? '',
      buildSignature: map['buildSignature'] ?? '',
      installerStore: map['installerStore'] as String?,
    );
  }

  @override
  Future<DeviceInfoAndroid> getDeviceInfoAndroid() async {
    final map = await methodChannel.invokeMapMethod<String, dynamic>('getDeviceInfo');
    return DeviceInfoAndroid.fromMap(map!);
  }

  @override
  Future<DeviceInfoIos> getDeviceInfoIos() async {
    final map = await methodChannel.invokeMapMethod<String, dynamic>('getDeviceInfo');
    return DeviceInfoIos.fromMap(map!);
  }
}
