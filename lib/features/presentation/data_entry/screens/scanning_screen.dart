import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/manual_entry_screen.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/refine_scan_screen.dart';

class ScanningScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;

  const ScanningScreen({super.key, required this.db, required this.userId});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  late List<File> _selectedImages;

  int _currentIndex = 0;

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

  Future<void> _done() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RefineScanScreen(images: _selectedImages),
      ),
    );
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _selectedImages.isEmpty
            ? [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.photo), label: 'Gallery'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt), label: 'Camera'),
                // const BottomNavigationBarItem(icon: ))
              ]
            : [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.add_photo_alternate), label: 'Gallery'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.add_a_photo), label: 'Camera'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.check), label: 'Done')
              ],
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            // photo gallery
            _pickImageFromGallery();
          } else if (index == 1) {
            // from camera
            _pickImageFromCamera();
          } else if (index == 2) {
            _done;
          }
        },
      ),
    );
  }
}
