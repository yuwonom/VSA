import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:vsa/themes/theme.dart';

class VSAMapIntersections extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    const pathWidth = 100.0;

    final paint = Paint()
      ..color = AppColors.black
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final points = <Offset> [
      Offset(0 - strokeWidth, size.height / 2.0 - pathWidth / 2.0),
      Offset(size.width / 2.0 - pathWidth / 2.0, size.height / 2.0 - pathWidth / 2.0),
      Offset(size.width / 2.0 - pathWidth / 2.0, 0 - strokeWidth),
      Offset(size.width / 2.0 + pathWidth / 2.0, 0 - strokeWidth),
      Offset(size.width / 2.0 + pathWidth / 2.0, size.height / 2.0 - pathWidth / 2.0),
      Offset(size.width + strokeWidth, size.height / 2.0 - pathWidth / 2.0),
      Offset(size.width + strokeWidth, size.height / 2.0 + pathWidth / 2.0),
      Offset(size.width / 2.0 + pathWidth / 2.0, size.height / 2.0 + pathWidth / 2.0),
      Offset(size.width / 2.0 + pathWidth / 2.0, size.height + strokeWidth),
      Offset(size.width / 2.0 - pathWidth / 2.0, size.height + strokeWidth),
      Offset(size.width / 2.0 - pathWidth / 2.0, size.height / 2.0 + pathWidth / 2.0),
      Offset(0 - strokeWidth, size.height / 2.0 + pathWidth / 2.0),
    ];
      
    canvas.drawPoints(PointMode.polygon, points, paint);
    
    final path = Path()
      ..moveTo(points.first.dx, points.first.dy);
    points.forEach((Offset offset) => path.lineTo(offset.dx, offset.dy));

    paint.color = AppColors.roadGray;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}