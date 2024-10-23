package sing.top.plugin_tools


import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageInfo
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
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

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
    } else if (call.method == "getPackageInfo") {
      val packageManager = activity!!.packageManager
      val info = packageManager.getPackageInfo(activity!!.packageName, 0)
      val buildSignature = getBuildSignature(packageManager)
      val installerPackage = getInstallerPackageName()
      val infoMap = HashMap<String, String>()
      infoMap.apply {
        put("appName", info.applicationInfo?.loadLabel(packageManager)?.toString() ?: "")
        put("packageName", activity!!.packageName)
        put("version", info.versionName ?: "")
        put("buildNumber", getLongVersionCode(info).toString())
        if (buildSignature != null) put("buildSignature", buildSignature)
        if (installerPackage != null) put("installerStore", installerPackage)
      }.also { resultingMap ->
        result.success(resultingMap)
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

  /**
   * Using initiatingPackageName on Android 11 and newer because it can't be changed
   * https://developer.android.com/reference/android/content/pm/InstallSourceInfo#getInitiatingPackageName()
   */
  private fun getInstallerPackageName(): String? {
    val packageManager = activity!!.packageManager
    val packageName = activity!!.packageName
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
      packageManager.getInstallSourceInfo(packageName).initiatingPackageName
    } else {
      @Suppress("DEPRECATION")
      packageManager.getInstallerPackageName(packageName)
    }
  }

  @Suppress("deprecation")
  private fun getLongVersionCode(info: PackageInfo): Long {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
      info.longVersionCode
    } else {
      info.versionCode.toLong()
    }
  }

  @Suppress("deprecation", "PackageManagerGetSignatures")
  private fun getBuildSignature(pm: PackageManager): String? {
    return try {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        val packageInfo = pm.getPackageInfo(activity!!.packageName, PackageManager.GET_SIGNING_CERTIFICATES)
        val signingInfo = packageInfo.signingInfo ?: return null

        if (signingInfo.hasMultipleSigners()) {
          signatureToSha256(signingInfo.apkContentsSigners.first().toByteArray())
        } else {
          signatureToSha256(signingInfo.signingCertificateHistory.first().toByteArray())
        }
      } else {
        val packageInfo = pm.getPackageInfo(activity!!.packageName, PackageManager.GET_SIGNATURES)
        val signatures = packageInfo.signatures

        if (signatures.isNullOrEmpty() || signatures.first() == null) {
          null
        } else {
          signatureToSha256(signatures.first().toByteArray())
        }
      }
    } catch (e: PackageManager.NameNotFoundException) {
      null
    } catch (e: NoSuchAlgorithmException) {
      null
    }
  }

  // Credits https://gist.github.com/scottyab/b849701972d57cf9562e
  @Throws(NoSuchAlgorithmException::class)
  private fun signatureToSha256(sig: ByteArray): String {
    val digest = MessageDigest.getInstance("SHA-256")
    digest.update(sig)
    val hashText = digest.digest()
    return bytesToHex(hashText)
  }

  // Credits https://gist.github.com/scottyab/b849701972d57cf9562e
  private fun bytesToHex(bytes: ByteArray): String {
    val hexArray = charArrayOf(
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
    )
    val hexChars = CharArray(bytes.size * 2)
    var v: Int
    for (j in bytes.indices) {
      v = bytes[j].toInt() and 0xFF
      hexChars[j * 2] = hexArray[v ushr 4]
      hexChars[j * 2 + 1] = hexArray[v and 0x0F]
    }
    return String(hexChars)
  }
}
