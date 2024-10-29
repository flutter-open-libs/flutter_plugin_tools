package sing.top.plugin_tools

import android.app.Activity
import android.app.ActivityManager
import android.content.pm.FeatureInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.DisplayMetrics
import android.view.Display
import android.view.WindowManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import kotlin.collections.HashMap

class PackageInfo(private val activity: Activity) {

    fun getPackageInfo() : MutableMap<String, Any> {
        val packageManager = activity.packageManager
        val info = packageManager.getPackageInfo(activity.packageName, 0)
        val buildSignature = getBuildSignature(packageManager)
        val installerPackage = getInstallerPackageName()
        val infoMap: MutableMap<String, Any> = HashMap()

        infoMap.put("appName", info.applicationInfo?.loadLabel(packageManager)?.toString() ?: "")
        infoMap.put("packageName", activity!!.packageName)
        infoMap.put("version", info.versionName ?: "")
        infoMap.put("buildNumber", getLongVersionCode(info).toString())
        if (buildSignature != null) infoMap.put("buildSignature", buildSignature)
        if (installerPackage != null) infoMap.put("installerStore", installerPackage)

        return infoMap;
    }


    @Suppress("deprecation", "PackageManagerGetSignatures")
    private fun getBuildSignature(pm: PackageManager): String? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                val packageInfo = pm.getPackageInfo(activity.packageName, PackageManager.GET_SIGNING_CERTIFICATES)
                val signingInfo = packageInfo.signingInfo ?: return null

                if (signingInfo.hasMultipleSigners()) {
                    signatureToSha256(signingInfo.apkContentsSigners.first().toByteArray())
                } else {
                    signatureToSha256(signingInfo.signingCertificateHistory.first().toByteArray())
                }
            } else {
                val packageInfo = pm.getPackageInfo(activity.packageName, PackageManager.GET_SIGNATURES)
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
}