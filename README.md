# flutter 插件、工具


### 安装

在项目的 `pubspec.yaml` 中添加：

```
dependencies:
  sing_plugin_tools: ^0.0.1
```

### API

* 获取 androidId (仅支持 Android)

    ```
    String androidId = await _flutterPluginToolsPlugin.getAndroidID() ?? '-1';
    ```

* 请求手机状态权限，仅支持 Android，Android10以上无法获取

    ```
    var t = await _flutterPluginToolsPlugin.requestPhoneState() ?? '-1';  
    var phoneState = int.tryParse(t) ?? 0; // // 权限状态，-1是不可获取，0是拒绝，1是通过
    ```

* 请求 imei ，仅支持 Android，Android10 以上无法获取

    ```
    String androidImei = await _flutterPluginToolsPlugin.getAndroidImei() ?? '-1';
    ```

* 请求 oaid，仅支持 Android，Android10 以下可能无法获取

    ```
    String androidOaid = await _flutterPluginToolsPlugin.getAndroidOaid() ?? '-1';
    ```

* 请求 idfa，仅支持 iOS

    ```
    String idfa = await _flutterPluginToolsPlugin.getIosIdfa() ?? '-1';
    ```


### 后续工具继续补充...