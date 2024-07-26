import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';

/// 水平分割线
class LineHorizontal extends StatelessWidget {
  const LineHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColor.line,height: 0.2);
  }
}
