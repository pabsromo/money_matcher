import 'package:flutter/material.dart';

class DraggableBox extends StatelessWidget {
  final Offset position;
  final VoidCallback onDragStart;
  final Function(Offset) onDragEnd;

  const DraggableBox({
    Key? key,
    required this.position,
    required this.onDragStart,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanStart: (_) => onDragStart(),
        onPanUpdate: (details) => onDragEnd(details.globalPosition),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
