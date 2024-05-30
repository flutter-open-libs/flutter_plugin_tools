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
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
