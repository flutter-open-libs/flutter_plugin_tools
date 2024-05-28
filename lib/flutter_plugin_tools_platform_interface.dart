import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_plugin_tools_method_channel.dart';

abstract class FlutterPluginToolsPlatform extends PlatformInterface {
  /// Constructs a FlutterPluginToolsPlatform.
  FlutterPluginToolsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPluginToolsPlatform _instance = MethodChannelFlutterPluginTools();

  /// The default instance of [FlutterPluginToolsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPluginTools].
  static FlutterPluginToolsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPluginToolsPlatform] when
  /// they register themselves.
  static set instance(FlutterPluginToolsPlatform instance) {
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
}
