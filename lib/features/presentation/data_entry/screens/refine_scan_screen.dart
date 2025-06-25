import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/selected_images_viewer.dart';

class RefineScanScreen extends StatefulWidget {
  static Route<List<File>> route({required List<File> selectedImages}) =>
      MaterialPageRoute(
          builder: (_) => RefineScanScreen(selectedImages: selectedImages));

  final List<File> selectedImages;
  const RefineScanScreen({super.key, required this.selectedImages});

  @override
  State<RefineScanScreen> createState() => _RefineScanScreenState();
}

class _RefineScanScreenState extends State<RefineScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('refineScanScreen'),
      appBar: AppBar(
        title: const Text('Refine Scan'),
      ),
      body: SelectedImagesViewer(
        selectedImages: widget.selectedImages,
        onMoveUp: null,
        onMoveDown: null,
        onDelete: null,
        isEditable: false,
      ),
    );
  }
}
