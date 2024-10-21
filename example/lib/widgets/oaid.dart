import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';

import 'package:sing_plugin_tools/method_channel/sing_plugin_tools.dart';

class Oaid extends StatefulWidget {
  const Oaid({super.key});

  @override
  State<Oaid> createState() => _OaidState();
}

class _OaidState extends State<Oaid> {
  String _androidOaid = '';
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getAndroidOaid() async {
    if(Platform.isAndroid){
      String androidOaid = await _flutterPluginToolsPlugin.getAndroidOaid() ?? '-1';
      if(androidOaid == '-1'){
        setState(() => _androidOaid = '没有获取到或设备不支持');
      }else{
        setState(() => _androidOaid = androidOaid);
      }
    }else{
      setState(() => _androidOaid = '该设备类型不支持');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getAndroidOaid(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android oaid',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidOaid,style: const TextStyle(color: Colors.grey,fontSize: 14)),
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
            child: const Text('无需权限，仅Android10以上支持',style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}