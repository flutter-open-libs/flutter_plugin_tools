# flutter 插件、工具


## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

// 仅支持 Android
String androidId = await _flutterPluginToolsPlugin.getAndroidID() ?? '-1';
// 仅支持 Android
var t = await _flutterPluginToolsPlugin.requestPhoneState() ?? '-1';
var phoneState = int.tryParse(t) ?? 0; // // 权限状态，-1是不可获取，0是拒绝，1是通过
// 仅支持 Android
String androidImei = await _flutterPluginToolsPlugin.getAndroidImei() ?? '-1';
// 仅支持 Android
String androidOaid = await _flutterPluginToolsPlugin.getAndroidOaid() ?? '-1';
// 仅支持 IDFA
String idfa = await _flutterPluginToolsPlugin.getIosIdfa() ?? '-1';