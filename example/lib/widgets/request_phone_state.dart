import 'dart:io';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

import 'package:sing_plugin_tools/method_channel/sing_plugin_tools.dart';

class RequestPhoneState extends StatefulWidget {
  const RequestPhoneState({super.key});

  @override
  State<RequestPhoneState> createState() => _RequestPhoneStateState();
}

class _RequestPhoneStateState extends State<RequestPhoneState> {
  String _phoneState = '';
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<int> requestPhoneState() async {
    if(Platform.isAndroid){
      var t = await _flutterPluginToolsPlugin.requestPhoneState() ?? '-1';
      var phoneState = int.tryParse(t) ?? 0; // // 权限状态，-1是不可获取，0是拒绝，1是通过
      setState(() {
        if(phoneState == 1){
          _phoneState = '权限通过';
        }else if(phoneState == 0){
          _phoneState = '权限拒绝';
        }else{
          _phoneState = '无法获取';
        }
      });
      return phoneState;
    }else{
      setState(() => _phoneState = '该设备类型不支持');
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => requestPhoneState(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('请求 READ_PHONE_STATE 权限',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_phoneState,style: const TextStyle(color: Colors.grey,fontSize: 14)),
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
            child: const Text('仅Android10以下',style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}