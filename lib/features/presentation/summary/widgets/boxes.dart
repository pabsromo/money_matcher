import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  final int left;
  final int right;
  final Function(int, int) onBoxTap;
  final Map<String, Offset> boxPositions;

  const Boxes({
    required this.left,
    required this.right,
    required this.onBoxTap,
    required this.boxPositions,
  });

  @override
  Widget build(BuildContext context) {
    print("building...");
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              left,
                  (index) => _buildBox(index, 1, context),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              right,
                  (index) => _buildBox(index, 2, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(int index, int col, BuildContext context) {
    String boxId = "Box $col-$index";
    print("Starting _buildBox");
    print(boxId);
    GlobalKey boxKey = GlobalKey(); // Assign a key to track position

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final RenderBox? box = boxKey.currentContext?.findRenderObject() as RenderBox?;
    //   if (box != null) {
    //     final Offset position = box.localToGlobal(Offset.zero);
    //     registerBoxPosition(boxId, position);
    //     print("Registered position for $boxId at $position"); // Debugging
    //   }
    // });

    // Calculate approximate position at creation
    Offset approximatePosition = Offset(col * 200, index * 120);
    boxPositions[boxId] = approximatePosition;

    print("Registered position for $boxId at $approximatePosition");

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () => onBoxTap(col, index),
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xffe4f2fd),
            foregroundDecoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffc2d2e1),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(boxId, style: TextStyle(color: Colors.black),),
            ),
          ),
        );
      },
    );
  }
}
