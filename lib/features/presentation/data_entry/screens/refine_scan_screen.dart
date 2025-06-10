import 'dart:io';

import 'package:flutter/material.dart';

class RefineScanScreen extends StatefulWidget {
  static Route<List<File>> route({required List<File> images}) =>
      MaterialPageRoute(builder: (_) => RefineScanScreen(images: images));

  final List<File> images;
  const RefineScanScreen({super.key, required this.images});

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
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.file(widget.images[index]),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.arrow_upward,
                                color: Colors.yellow))),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.delete, color: Colors.red)))
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
