import 'dart:io';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

import 'package:sing_plugin_tools/method_channel/sing_plugin_tools.dart';

class Imei extends StatefulWidget {
  const Imei({super.key});

  @override
  State<Imei> createState() => _ImeiState();
}

class _ImeiState extends State<Imei> {
  String _androidImei = '';
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getImei() async {
    if(Platform.isAndroid){
      var t = await _flutterPluginToolsPlugin.requestPhoneState() ?? '-1';
      var phoneState = int.tryParse(t) ?? 0; // // 权限状态，-1是不可获取，0是拒绝，1是通过
      if(phoneState == 1){
        var androidImei = await _flutterPluginToolsPlugin.getAndroidImei();
        setState(() => _androidImei = '$androidImei');
      }else if(phoneState == 0){
        setState(() => _androidImei = '权限不通过');
      }else{
        setState(() => _androidImei = '不可获取');
      }
    }else{
      setState(() => _androidImei = '该设备类型不支持');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getImei(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android imei',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidImei,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                SingImage('images/ic_next.png',width: 15.w)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
            ),
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 12),
            child: const Text('需要权限(仅Android10以下) : READ_PHONE_STATE',style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }


}