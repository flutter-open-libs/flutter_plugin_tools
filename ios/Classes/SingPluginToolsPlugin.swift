import Flutter
import UIKit
import AppTrackingTransparency
import AdSupport

public class SingPluginToolsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "sing.top/flutter_plugin_tools", binaryMessenger: registrar.messenger())
    let instance = SingPluginToolsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getIosIdfa":
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                    case .authorized:
                        print("用户授权使用 IDFA")
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                        result(idfa)
                    case .denied: // 用户拒绝使用 IDFA
                        result("-1")
                    case .notDetermined: // 用户尚未决定是否允许使用 IDFA
                        result("-2")
                    case .restricted: // 用户限制了使用 IDFA
                        result("-3")
                    @unknown default:
                        break
                    }
                }
        } else { // 在 iOS 14 以下版本，可以直接访问 IDFA
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            result(idfa)
        }
    case "getPackageInfo":
        let appStoreReceiptPath = Bundle.main.appStoreReceiptURL?.path ?? ""
        let installerStore: String
        if appStoreReceiptPath.contains("CoreSimulator") {
            installerStore = "com.apple.simulator"
        } else if appStoreReceiptPath.contains("sandboxReceipt") {
            installerStore = "com.apple.testflight"
        } else {
            installerStore = "com.apple"
        }

        let appInfo: [String: Any] = [
            "appName": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") ?? NSNull(),
            "packageName": Bundle.main.bundleIdentifier ?? NSNull(),
            "version": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? NSNull(),
            "buildNumber": Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? NSNull(),
            "installerStore": installerStore
        ]
        result(appInfo)
    case "getDeviceInfo":
        let device = UIDevice.current
        var systemInfo = utsname()
        uname(&systemInfo)

        func convertToString(_ field: Int8...) -> String {
            return field.map { String(UnicodeScalar(UInt8($0))) }.joined()
        }

        let sysname = convertToString(systemInfo.sysname.0, systemInfo.sysname.1, systemInfo.sysname.2, systemInfo.sysname.3, systemInfo.sysname.4, systemInfo.sysname.5, systemInfo.sysname.6, systemInfo.sysname.7, systemInfo.sysname.8, systemInfo.sysname.9, systemInfo.sysname.10, systemInfo.sysname.11, systemInfo.sysname.12, systemInfo.sysname.13, systemInfo.sysname.14, systemInfo.sysname.15)
        let nodename = convertToString(systemInfo.nodename.0, systemInfo.nodename.1, systemInfo.nodename.2, systemInfo.nodename.3, systemInfo.nodename.4, systemInfo.nodename.5, systemInfo.nodename.6, systemInfo.nodename.7, systemInfo.nodename.8, systemInfo.nodename.9, systemInfo.nodename.10, systemInfo.nodename.11, systemInfo.nodename.12, systemInfo.nodename.13, systemInfo.nodename.14, systemInfo.nodename.15)
        let release = convertToString(systemInfo.release.0, systemInfo.release.1, systemInfo.release.2, systemInfo.release.3, systemInfo.release.4, systemInfo.release.5, systemInfo.release.6, systemInfo.release.7, systemInfo.release.8, systemInfo.release.9, systemInfo.release.10, systemInfo.release.11, systemInfo.release.12, systemInfo.release.13, systemInfo.release.14, systemInfo.release.15)
        let version = convertToString(systemInfo.version.0, systemInfo.version.1, systemInfo.version.2, systemInfo.version.3, systemInfo.version.4, systemInfo.version.5, systemInfo.version.6, systemInfo.version.7, systemInfo.version.8, systemInfo.version.9, systemInfo.version.10, systemInfo.version.11, systemInfo.version.12, systemInfo.version.13, systemInfo.version.14, systemInfo.version.15)
        let machine = convertToString(systemInfo.machine.0, systemInfo.machine.1, systemInfo.machine.2, systemInfo.machine.3, systemInfo.machine.4, systemInfo.machine.5, systemInfo.machine.6, systemInfo.machine.7, systemInfo.machine.8, systemInfo.machine.9, systemInfo.machine.10, systemInfo.machine.11, systemInfo.machine.12, systemInfo.machine.13, systemInfo.machine.14, systemInfo.machine.15)

        let deviceInfo: [String: Any] = [
            "name": device.name,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "model": device.model,
            "localizedModel": device.localizedModel,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? NSNull(),
            "isPhysicalDevice": NSNumber(value: isDevicePhysical()),
            "utsname": [
                "sysname": sysname,
                "nodename": nodename,
                "release": release,
                "version": version,
                "machine": machine,
            ]
        ]

        result(deviceInfo)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  private func isDevicePhysical() -> Bool {
    #if targetEnvironment(simulator)
      return false
    #else
      return true
    #endif
  }
}
