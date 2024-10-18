import 'package:flutter/material.dart';

/// 虚线
/// DashedLine(
///   color: Colors.blue, // 可选参数，默认为黑色
///   dashWidth: 10.0,    // 可选参数，默认为5.0
///   width: 300.0,       // 可选参数，默认为200.0
/// )
class DashedLinePainter extends CustomPainter {
  final Color color; // 颜色
  final double dashWidth; // 每段虚线的长度
  final double dashSpace; // 每段虚线之间的间距
  final double strokeWidth; // 线条宽度

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final space = (dashSpace + dashWidth);

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class SingDashedLine extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final double width;
  final double height;

  SingDashedLine({
    this.color = Colors.black,   // 默认黑色虚线
    this.dashWidth = 5.0,        // 默认虚线长度为5.0
    this.dashSpace = 3.0,        // 默认间隔为3.0
    this.strokeWidth = 1.0,      // 默认线条宽度为1.0
    this.width = 200.0,          // 默认宽度为200
    this.height = 1.0,           // 默认高度为1.0
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height), // 控制虚线长度和高度
      painter: DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        strokeWidth: strokeWidth,
      ),
    );
  }
}