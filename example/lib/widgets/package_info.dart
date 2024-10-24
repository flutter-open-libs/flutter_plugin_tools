import 'package:sing_plugin_tools/export.dart';
import 'dart:async';


class Package extends StatefulWidget {
  const Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  PackageInfo? _packageInfo;

  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getPackageInfo() async {
    PackageInfo packageInfoTemp = await _flutterPluginToolsPlugin.getPackageInfo();
    setState(() => _packageInfo = packageInfoTemp);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getPackageInfo(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 PackageInfo',style: TextStyle(color: Colors.black87,fontSize: 14))),
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
            child:  Text(_packageInfo.toString(),style: const TextStyle(color: Colors.grey,fontSize: 12)),
          ),
        ],
      ),
    );
  }
}