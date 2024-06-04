import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sing_plugin_tools/sing_plugin_tools.dart';
import 'package:sing_plugin_tools/widgets/sing_cell_item.dart';
import 'package:sing_plugin_tools/widgets/sing_button.dart';

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
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = '我是副标题';
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
              SingCellItem(
                backgroundColor: Colors.white, // 背景颜色，默认透明
                height: 56.0, // item 的高度
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                // assetPath: 'assets/images/ic_feedback.png', // 前面 icon 的 asset 路径，为空则不展示
                iconSize: const Size(28.0,28.0), // 前面 icon 的大小，assetPath 为空则不展示
                gap: 12.0, // icon 和标题的间距
                title: '我是Item', // 标题
                titleTextStyle: const TextStyle(color: Color(0xFF131732), fontSize: 16.0), // 标题样式
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))), // 边框的样式，默认底部一条线
                onTap: ()=> print('点击主标题'), // item 的点击事件
                // separator: Container(width: 200.0,height: 1.0,color: Colors.grey), // 自定义的装饰，正常是一根线，在 decoration 满足不了的情况下自定义，比如项左右有边距。当然其他 widget 也可以
                showNext: true, // 是否显示右侧箭头
                nextIcon: const Icon(Icons.arrow_forward_ios,size: 16.0,color:Colors.grey), // 右侧的箭头，可以是任何 Widget

                showSub: false, // 是否显示副标题，副标题是一个 TextField
                focusNode: FocusNode(), // 控制副标题的副控件 KeyboardListener
                controller: textController, // TextField 的 controller ，可以设置文字，取值也通过他
                subTitleTextStyle : const TextStyle(color: Color(0xFF131732), fontSize: 14.0), // 副标题样式
                subTitleHint: '请输入副标题', // 副标题的提示语
                subTitleHintTextStyle : const TextStyle(color: Colors.grey, fontSize: 14.0),// 副标题的提示语的样式
                subTitleContentPadding : const EdgeInsets.symmetric(vertical: 12.0), // 副标题的 ContentPadding
                readOnly:false, // 副标题 TextField 的是否能编辑
                onSubTap: ()=> print('点击副标题'), // 副标题点击事件
                customWidget: Container( // 自定义的 Widget ，在副标题之后，箭头之前，自己控制间距
                  decoration: const BoxDecoration(
                      color: Color(0xffE9F7FE),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text('  自定义  ',style: TextStyle(color: Colors.grey,fontSize: 12.0))
                )
              ),
              SingButton(
                title : 'SingButton', // 按钮文字
                titleTextStyle : const TextStyle(color: Colors.white,fontSize: 16.0), // 按钮样式
                fillColor : const Color(0xFF19B1F4),   // 填充颜色
                highlightColor : const Color(0x40CCCCCC), // 按下颜色
                size : const Size(88.0,36.0), // 按钮大小
                elevation : 0, // 阴影
                highlightElevation : 0, // 按下阴影
                side : const BorderSide(color: Colors.transparent,width: 0.2), // 边框
                // sideColor : Colors.transparent, // 传 side 后无效
                // sideWidth : 0.2, // 传 side 后无效
                borderRadius : const BorderRadius.all(Radius.circular(20.0)), // 样式
                // radius : 20.0,  // 传 borderRadius 后无效
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 3.0),
                margin: EdgeInsets.zero,
                onPressed : ()=> { }, // 点击事件
                onLongPress : ()=> debugPrint('SingButton Long Clicked'),
              ),
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
            child:  Text(_iosIdfa,style: const TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
