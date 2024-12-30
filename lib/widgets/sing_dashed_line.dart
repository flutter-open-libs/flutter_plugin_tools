import 'package:sing_plugin_tools/export.dart';

/// 虚线
/// DashedLine(
///   color: Colors.blue, // 可选参数，默认为黑色
///   dashWidth: 10.0,    // 可选参数，默认为5.0
///   width: 300.0,       // 可选参数，默认为200.0
/// )
class DashedLinePainter extends CustomPainter {
  final Color color; // 颜色
  final double dashWidth; // 每段虚线的长度
  final double dashHeight; // 每段虚线的高度
  final double dashSpace; // 每段虚线之间的间距
  final bool isRound; // 是否圆角

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpace,
    required this.isRound,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = dashHeight
      ..style = PaintingStyle.stroke
      ..strokeCap = isRound ? StrokeCap.round : StrokeCap.butt; // 设置线条两端为圆角

    double startX = 0;
    final space = (dashSpace + dashWidth);

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth - (isRound ? dashHeight : 0), 0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.dashHeight != dashHeight;
  }
}

class SingDashedLine extends StatelessWidget {
  final Color? color;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final double width;
  final double height;
  final bool isRound;

  const SingDashedLine({
    super.key,
    this.color,                  // 虚线颜色
    this.dashWidth = 5.0,        // 默认虚线长度为5.0
    this.dashHeight = 1.0,       // 默认虚线高度为5.0
    this.dashSpace = 3.0,        // 默认间隔为3.0
    this.width = 200.0,          // 默认宽度为200
    this.height = 1.0,           // 默认高度为1.0
    this.isRound = true,         // 是否圆角
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height), // 控制虚线长度和高度
      painter: DashedLinePainter(
        color: color ?? AppColor.line,
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        dashSpace: dashSpace,
        isRound: isRound,
      ),
    );
  }
}