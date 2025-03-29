import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  final int left;
  final int right;

  const Boxes({
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left column with 3 boxes
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              left,
                  (index) => _buildBox(index, 1),
            ),
          ),

          // Right column with 2 boxes
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              right,
                  (index) => _buildBox(index, 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(int index, int col) {
    print('making box $col, $index');

    return Container(
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
      child: const Center(
        child: Text('MyBox'),
      ),
    );
  }
}
