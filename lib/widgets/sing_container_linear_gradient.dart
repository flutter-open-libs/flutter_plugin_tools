import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/export.dart';

class SingContainerLinearGradient extends StatelessWidget {

  final double? width;
  final double? height;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Widget? child;

  const SingContainerLinearGradient({
    super.key,
    this.width,
    this.height,
    this.colors = const [],
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var tempColors = [AppColor.main, const Color(0xfff2f6ff)];
    return Container(
      width: width ?? Get.width,
      height: height ?? Get.width / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors.isNotEmpty ? colors : tempColors,
        ),
      ),
      child: child ?? Container(), // 如果没有子view，则使用空容器
    );
  }
}
