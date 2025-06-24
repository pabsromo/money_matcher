import 'dart:io';

import 'package:flutter/material.dart';

class SelectedImagesViewer extends StatelessWidget {
  final List<File> selectedImages;
  final void Function(int) onMoveUp;
  final void Function(int) onMoveDown;
  final void Function(int) onDelete;

  const SelectedImagesViewer({
    super.key,
    required this.selectedImages,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(selectedImages.length, (index) {
            return Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.file(selectedImages[index]),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      if (index != 0)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => onMoveUp(index),
                              icon: const Icon(Icons.arrow_upward,
                                  color: Colors.yellow),
                              tooltip: 'Move Up',
                            ),
                          ),
                        ),
                      if (index != selectedImages.length - 1)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => onMoveDown(index),
                              icon: const Icon(Icons.arrow_downward,
                                  color: Colors.yellow),
                              tooltip: 'Move Down',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => onDelete(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Delete',
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
