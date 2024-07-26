import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';

/// 垂直分割线
class LineVertical extends StatelessWidget {
  const LineVertical({super.key,this.height = 10.0});

  final double height;

  @override
  Widget build(BuildContext context) {
    if(height > 0){
      return Container(color: AppColor.line,width: 0.2,height: height);
    }else{
      return Container(color: AppColor.line,width: 0.2);
    }
  }
}
