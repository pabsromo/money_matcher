import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  final Map<String, Offset> boxPositions;
  final List<Map<String, String>> connections;

  LinesPainter(this.boxPositions, this.connections);

  @override
  void paint(Canvas canvas, Size size) {
    print("Painting...");
    print("boxPositions: $boxPositions");
    print("connections: $connections");
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.redAccent;

    for (var connection in connections) {
      String? startBox = connection["start"];
      String? endBox = connection["end"];

      if (startBox != null && endBox != null &&
          boxPositions.containsKey(startBox) &&
          boxPositions.containsKey(endBox)) {
        Offset start = boxPositions[startBox]!;
        Offset end = boxPositions[endBox]!;

        print("Drawing line from $startBox to $endBox at $start -> $end"); // ✅ Debugging
        canvas.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.connections != connections ||
        oldDelegate.boxPositions != boxPositions;
  }
}
