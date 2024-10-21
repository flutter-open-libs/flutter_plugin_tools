import 'dart:io';
import 'package:sing_plugin_tools/export.dart';
import 'dart:async';


class AndroidId extends StatefulWidget {
  const AndroidId({super.key});

  @override
  State<AndroidId> createState() => _AndroidIdState();
}

class _AndroidIdState extends State<AndroidId> {
  String _androidId = '';

  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getAndroidID() async {
    if(Platform.isAndroid){
      String androidId = await _flutterPluginToolsPlugin.getAndroidID() ?? '-1';
      setState(() => _androidId = androidId);
    }else{
      setState(() => _androidId = '该设备类型不支持');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getAndroidID(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 Android id',style: TextStyle(color: Colors.black87,fontSize: 14))),
                Text(_androidId,style: const TextStyle(color: Colors.grey,fontSize: 14)),
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
            child: const Text('无需额外的权限',style: TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}