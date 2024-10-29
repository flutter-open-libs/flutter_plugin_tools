import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({super.key});

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getDeviceInfo() async {
    if(GetPlatform.isAndroid) {
      DeviceInfoAndroid deviceInfoTemp = await _flutterPluginToolsPlugin.getDeviceInfoAndroid();
      show(deviceInfoTemp.toString());
    } else if(GetPlatform.isIOS){
      DeviceInfoIos deviceInfoTemp = await _flutterPluginToolsPlugin.getDeviceInfoIos();
      show(deviceInfoTemp.toString());
    }else{
      show('暂不支持');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getDeviceInfo(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
            ),
            child: Row(
              children: [
                const Expanded(child: Text('获取 DeviceInfo',style: TextStyle(color: Colors.black87,fontSize: 14))),
                SingImage('images/ic_next.png',width: 15.w)
              ],
            ),
          ),
        ],
      ),
    );
  }

  show(info){
    Get.dialog(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w,vertical: 150.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.w),
        decoration: decorationWhiteRadius8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(info,style: text_131732_12.copyWith(fontSize: 10.sp))
            ],
          ),
        ),
      )
    );
  }
}