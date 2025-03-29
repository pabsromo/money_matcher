import 'package:flutter/material.dart';
import 'lines_painter.dart';

class Lines extends StatefulWidget {
  final Map<String, Offset> boxPositions;
  final List<Map<String, String>> connections; // Pairs of box IDs

  const Lines({
    required this.boxPositions,
    required this.connections,
    super.key,
  });

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: LinesPainter(widget.boxPositions, widget.connections),
    );
  }
}
