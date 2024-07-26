import 'package:flutter/material.dart';
import 'package:sing_plugin_tools/theme/app_colors.dart';

class CustomIndicator extends Decoration {

  final double indWidth;
  final double indHeight;
  final double radius;

  const CustomIndicator({this.indWidth = 40.0, this.indHeight = 2.0, this.radius = 1});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(this, onChanged, indWidth, indHeight, radius);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final CustomIndicator decoration;
  final double indWidth;
  final double indHeight;
  final double radius;

  _CustomBoxPainter(this.decoration, VoidCallback? onChanged, this.indWidth, this.indHeight, this.radius)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    final newOffset = Offset(offset.dx + (size.width - indWidth) / 2, size.height - indHeight);
    final Rect rect = newOffset & Size(indWidth, indHeight);
    final Paint paint = Paint();
    paint.color = AppColor.main;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)), // 圆角半径
      paint,
    );
  }
}
