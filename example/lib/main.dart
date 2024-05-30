import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sing_plugin_tools/sing_plugin_tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _androidId = '';
  String _androidImei = '';
  String _phoneState = '';
  String _androidOaid = '';
  String _iosIdfa = '显示在这里';
  final _flutterPluginToolsPlugin = SingPluginTools();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getAndroidID() async {
    if(Platform.isAndroid){
      String androidId = await _flutterPluginToolsPlugin.getAndroidID() ?? '-1';
      setState(() => _androidId = androidId);
    }else{
      setState(() => _androidId = '该设备类型不支持');
    }
  }

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

  Future<void> getAndroidImei() async {
    if(Platform.isAndroid){
      requestPhoneState().then((value) =>  {
        if(value == 1){
          getImei()
        }else{
          _androidImei = '权限不通过'
        }
      });
    }else{
      setState(() => _androidImei = '该设备类型不支持');
    }
  }
  Future<void> getImei() async {
    String androidImei = await _flutterPluginToolsPlugin.getAndroidImei() ?? '-1';
    setState(() => _androidImei = androidImei);
  }
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFEFEFF4),
        appBar: AppBar(title: const Text('Flutter各种插件工具')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              buildGetAndroidID(),
              buildRequestPhoneState(),
              buildGetAndroidImei(),
              buildGetAndroidOaid(),
              buildGetIosIdfa(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGetAndroidID(){
    return InkWell(
      onTap: () => getAndroidID(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android id',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidId,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                Image.asset('images/ic_next.png',width: 15,height: 15)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
            ),
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 12),
            child: const Text('无需额外的权限',style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
  Widget buildRequestPhoneState(){
    return InkWell(
      onTap: () => requestPhoneState(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('请求 READ_PHONE_STATE 权限',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_phoneState,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                Image.asset('images/ic_next.png',width: 15,height: 15)
              ],
            ),
          ),
          Container(
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
  Widget buildGetAndroidImei(){
    return InkWell(
      onTap: () => getAndroidImei(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android imei',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidImei,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                Image.asset('images/ic_next.png',width: 15,height: 15)
              ],
            ),
          ),
          Container(
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
  Widget buildGetAndroidOaid(){
    return InkWell(
      onTap: () => getAndroidOaid(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android oaid',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidOaid,style: const TextStyle(color: Colors.grey,fontSize: 14)),
                Image.asset('images/ic_next.png',width: 15,height: 15)
              ],
            ),
          ),
          Container(
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
  Widget buildGetIosIdfa(){
    return InkWell(
      onTap: () => getIosIdfa(),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 iOS idfa  ',style: TextStyle(color: Colors.black87,fontSize: 14))),
                const Text('仅iOS支持',style: TextStyle(color: Colors.grey,fontSize: 14),overflow: TextOverflow.ellipsis),
                Image.asset('images/ic_next.png',width: 15,height: 15)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
            ),
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 12),
            child:  Text(_iosIdfa,style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
