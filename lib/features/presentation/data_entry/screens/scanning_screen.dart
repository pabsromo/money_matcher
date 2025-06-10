import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/manual_entry_screen.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/refine_scan_screen.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({super.key});

  @override
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  late List<File> _selectedImages;

  @override
  void initState() {
    super.initState();
    _selectedImages = [];
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImages.add(File(returnedImage.path));
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    setState(() {
      _selectedImages.add(File(returnedImage.path));
    });
  }

  Future _moveImageUp(int index) async {
    setState(() {
      File temp = _selectedImages[index];
      _selectedImages.removeAt(index);
      _selectedImages.insert(index - 1, temp);
    });
  }

  Future _deleteImage(int index) async {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key("scanningScreen"),
        appBar: AppBar(
          title: const Text('Scan'),
          actions: [
            Row(
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Skip'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ManualEntryScreen(),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_selectedImages.length, (index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.file(_selectedImages[index]),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () => _moveImageUp(index),
                            icon: const Icon(Icons.arrow_upward,
                                color: Colors.yellow))),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () => _deleteImage(index),
                            icon: const Icon(Icons.delete, color: Colors.red)))
                  ],
                );
              }),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _selectedImages.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      child: const Icon(Icons.add_photo_alternate))
                  : FloatingActionButton(
                      onPressed: () {
                        _pickImageFromGallery();
                      },
                      child: const Icon(Icons.photo),
                    ),
              _selectedImages.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          RefineScanScreen.route(images: _selectedImages),
                        );
                      },
                      child: const Icon(Icons.check))
                  : const Text(""),
              _selectedImages.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        _pickImageFromCamera();
                      },
                      child: const Icon(Icons.add_a_photo))
                  : FloatingActionButton(
                      onPressed: () {
                        _pickImageFromCamera();
                      },
                      child: const Icon(Icons.camera_alt),
                    )
            ],
          ),
        ));
  }
}
