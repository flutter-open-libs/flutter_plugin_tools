package sing.top.plugin_tools


import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import android.util.Log
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry
import com.umeng.commonsdk.UMConfigure

class SingPluginToolsPlugin: FlutterPlugin, MethodCallHandler , ActivityAware, PluginRegistry.RequestPermissionsResultListener {

  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var pendingResult: MethodChannel.Result? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sing.top/flutter_plugin_tools")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "getAndroidID") {
      val androidID = Settings.System.getString(activity?.contentResolver, Settings.Secure.ANDROID_ID)
      result.success(androidID)
    } else if (call.method == "requestPhoneState") {
//      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q &&Build.VERSION.SDK_INT>Build.VERSION_CODES.O){
      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q){
        pendingResult = result
        checkAndRequestPermission()
      }else{
        result.success("-1") // 无法获取
      }
    } else if (call.method == "getAndroidImei") {
      if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q){
        val telManager = activity?.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        val method = telManager.javaClass.getMethod("getImei")
        val imei = method.invoke(telManager)?.toString() ?: ""
        result.success(imei)
      }else{
        result.success("-1") // 无法获取
      }
    } else if (call.method == "getAndroidOaid") {
      UMConfigure.getOaid(activity) { s: String? ->
        if (!s.isNullOrEmpty()) { // 模拟器可能为空
          result.success(s)
        } else {
          result.success("-1")
        }
      }
    } else {
      result.notImplemented()
    }
  }

  private fun checkAndRequestPermission() {
    activity?.let {
      if (ContextCompat.checkSelfPermission(it, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
        ActivityCompat.requestPermissions(it, arrayOf(Manifest.permission.READ_PHONE_STATE), 11111)
      } else {
        pendingResult?.success("1") // 有权限
      }
    } ?: pendingResult?.error("ACTIVITY_NOT_AVAILABLE", "Activity is not available.", null)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addRequestPermissionsResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addRequestPermissionsResultListener(this)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray): Boolean {
    if (requestCode == 11111) {
      val granted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
      if (granted){
        pendingResult?.success("1") // 有权限
      }else{
        pendingResult?.success("0") // 无权限
      }
      pendingResult = null
    }
    return false
  }
}
