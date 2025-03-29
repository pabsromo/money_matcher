import 'package:flutter/material.dart';
import 'lines_painter.dart';

class Lines extends StatefulWidget {
  const Lines({super.key});

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  Offset? start;
  Offset? end;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Tapped'),
      onPanStart: (details) {
        print(details.localPosition);
        setState(() {
          start = details.localPosition;
          end = null;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          end = details.localPosition;
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: LinesPainter(start, end),
      ),
    );
  }
}
