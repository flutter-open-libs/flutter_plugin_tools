import 'dart:io';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

import 'package:sing_plugin_tools/method_channel/sing_plugin_tools.dart';

class Idfa extends StatefulWidget {
  const Idfa({super.key});

  @override
  State<Idfa> createState() => _IdfaState();
}

class _IdfaState extends State<Idfa> {
  String _iosIdfa = '显示在这里';
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getIosIdfa() async {
    if(Platform.isAndroid){
      setState(() => _iosIdfa = '该设备类型不支持');
    }else{
      String idfa = await _flutterPluginToolsPlugin.getIosIdfa() ?? '-1';
      if(idfa == '-1') {
        setState(() => _iosIdfa = '用户拒绝使用 IDFA');
      } else if(idfa == '-2'){
        setState(() => _iosIdfa = '用户尚未决定是否允许使用 IDFA');
      } else if(idfa == '-3'){
        setState(() => _iosIdfa = '用户限制了使用 IDFA');
      }else{
        setState(() => _iosIdfa = idfa);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getIosIdfa(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 iOS idfa  ',style: TextStyle(color: Colors.black87,fontSize: 14))),
                const Text('仅iOS支持',style: TextStyle(color: Colors.grey,fontSize: 14),overflow: TextOverflow.ellipsis),
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
            child:  Text(_iosIdfa,style: const TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}