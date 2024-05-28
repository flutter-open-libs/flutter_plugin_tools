import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_tools_platform_interface.dart';

/// An implementation of [FlutterPluginToolsPlatform] that uses method channels.
class MethodChannelFlutterPluginTools extends FlutterPluginToolsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sing.top/flutter_plugin_tools');

  @override
  Future<String?> getAndroidID() async {
    final androidID = await methodChannel.invokeMethod<String>('getAndroidID');
    return androidID;
  }

  @override
  Future<String?> getAndroidImei() async {
    final androidImei = await methodChannel.invokeMethod<String>('getAndroidImei');
    return androidImei;
  }

  @override
  Future<String?> requestPhoneState() async {
    final phoneState = await methodChannel.invokeMethod<String>('requestPhoneState');
    return phoneState;
  }

  @override
  Future<String?> getAndroidOaid() async {
    final oaid = await methodChannel.invokeMethod<String>('getAndroidOaid');
    return oaid;
  }

  @override
  Future<String?> getIosIdfa() async {
    final idfa = await methodChannel.invokeMethod<String>('getIosIdfa');
    return idfa;
  }
}
