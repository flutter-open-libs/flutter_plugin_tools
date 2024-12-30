import 'package:sing_plugin_tools/export.dart';

/// 水平分割线
class LineHorizontal extends StatelessWidget {
  const LineHorizontal({
    super.key,
    this.width,
    this.height = 0.2,
    this.radius = 0,
    this.color,
    this.margin,
  });

  final double? width;
  final double height;
  final double radius;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const LineHorizontal.w30({
    this.width = -1,
    this.height = 0.2,
    this.radius = 0,
    this.color,
    this.margin,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (width == -1 ? Get.width - 30.w : Get.width),
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColor.line,
        borderRadius: BorderRadius.all(Radius.circular(radius))
      ),
    );
  }
}

