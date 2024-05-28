import UIKit
import Flutter
import AppTrackingTransparency
import AdSupport

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "sing.top/flutter_plugin_tools", binaryMessenger: controller.binaryMessenger)

      channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "getIosIdfa" {
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
                        result("-1")
                    case .restricted: // 用户限制了使用 IDFA
                        result("-1")
                    @unknown default:
                        break
                    }
                }
            } else { // 在 iOS 14 以下版本，可以直接访问 IDFA
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                result(idfa)
            }
            
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
