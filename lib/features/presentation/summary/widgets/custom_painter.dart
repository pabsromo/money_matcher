import 'package:flutter/material.dart';

import '../../../domain/entities/BoxLink.dart';

class LinePainter extends CustomPainter {
  final List<BoxLink> links;

  LinePainter(this.links);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    for (var link in links) {
      canvas.drawLine(link.start, link.end, paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.links != links;
  }
}
