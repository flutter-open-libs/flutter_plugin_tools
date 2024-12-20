import 'package:sing_plugin_tools/export.dart';
import 'dart:async';


class Package extends StatefulWidget {
  const Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  final _flutterPluginToolsPlugin = SingPluginTools();

  Future<void> getPackageInfo() async {
    PackageInfo packageInfoTemp = await _flutterPluginToolsPlugin.getPackageInfo();
    show(packageInfoTemp.toString());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getPackageInfo(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
            ),
            padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
            child: Row(
              children: [
                const Expanded(child: Text('获取 PackageInfo',style: TextStyle(color: Colors.black87,fontSize: 14))),
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