
import 'package:flutter/material.dart';

class EllipsePainter extends CustomPainter {
  final double borderWidth;
  final Color borderColor;
  final double padding;
  final Color backgroundColor;

  EllipsePainter({
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.padding = 0.0,
    this.backgroundColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      borderWidth / 2 + padding,
      borderWidth / 2 + padding,
      size.width - borderWidth / 2 - padding,
      size.height - borderWidth / 2 - padding,
    );

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawOval(rect, paint);

    if (backgroundColor != Colors.transparent) {
      final backgroundRect = Rect.fromLTRB(
        padding,
        padding,
        size.width - padding,
        size.height - padding,
      );

      final backgroundPaint = Paint()..color = backgroundColor;

      canvas.drawOval(backgroundRect, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
