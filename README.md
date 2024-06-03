# flutter 插件、工具


### 安装

在项目的 `pubspec.yaml` 中添加：

```
dependencies:
  sing_plugin_tools: ^0.0.2
```

### API

* 获取 androidId (仅支持 Android)

    ```
    String androidId = await FlutterPluginTools().getAndroidID() ?? '-1';
    ```

* 请求手机状态权限，仅支持 Android，Android10以上无法获取

    ```
    var t = await FlutterPluginTools().requestPhoneState() ?? '-1';  
    var phoneState = int.tryParse(t) ?? 0; // // 权限状态，-1是不可获取，0是拒绝，1是通过
    ```

* 请求 imei ，仅支持 Android，Android10 以上无法获取

    ```
    String androidImei = await FlutterPluginTools().getAndroidImei() ?? '-1';
    ```

* 请求 oaid，仅支持 Android，Android10 以下可能无法获取

    ```
    String androidOaid = await FlutterPluginTools().getAndroidOaid() ?? '-1';
    ```

* 请求 idfa，仅支持 iOS，记得添加权限

    ```
    // -1:.denied,-2:.notDetermined,-3:.restricted
    String idfa = await FlutterPluginTools().getIosIdfa() ?? '-1'; 
    ```

* 创建通用列表项

  ```
  import 'package:sing_plugin_tools/widgets/sing_cell_item.dart';

  SingCellItem(
    height: 56.0,
    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0.0),
    assetPath: 'assets/images/ic_feedback.png',
    iconSize: const Size(28.0,28.0),
    gap: 12.0,
    text: '我是Item',
    textColor: const Color(0xff131732),
    textSize: 16.0,
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
    onTap: ()=> {},
    showNext: true,
    separator: Container(width: 200.0,height: 1.0,color: Colors.grey),
    nextIcon: const Icon(Icons.arrow_forward_ios,size: 16.0,color:Colors.grey),
  ),
  ```

### 后续工具继续补充...