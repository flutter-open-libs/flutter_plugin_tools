class PackageInfo {
  PackageInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
    this.installerStore,
  });

  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  final String appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  final String packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  final String buildNumber;

  /// The build signature. Contains the signing key signature (hex) on Android and empty string on everything else.
  final String buildSignature;

  /// The installer store. Indicates through which store this application was installed.
  final String? installerStore;

  @override
  String toString() {
    return 'appName: $appName\npackageName: $packageName\nversion: $version\nbuildNumber: $buildNumber\nbuildSignature: $buildSignature\ninstallerStore: $installerStore';
  }
}