import 'package:sing_plugin_tools/export.dart';

/// 垂直分割线
class LineVertical extends StatelessWidget {
  const LineVertical(
      this.height, {
      this.width = 0.2,
      this.radius = 0,
      this.color,
      this.margin,
      super.key,
    });

  final double width;
  final double height;
  final double radius;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColor.line,
        borderRadius: BorderRadius.all(Radius.circular(radius))
      ),
    );
  }
}
