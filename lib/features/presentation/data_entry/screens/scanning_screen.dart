import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/manual_entry_screen.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/refine_scan_screen.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/selected_images_viewer.dart';

import '../../../../db/images_dao.dart';

class ScanningScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;

  const ScanningScreen(
      {super.key,
      required this.db,
      required this.userId,
      required this.eventId});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  late List<File> _selectedImages;

  late ImagesDao _imagesDao;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _imagesDao = ImagesDao(widget.db);
    _selectedImages = [];

    _loadImages();
  }

  Future _loadImages() async {
    final storedImages = await _imagesDao.getEventImages(widget.eventId);
    final List<File> selectedImages = [];
    if (storedImages.isNotEmpty) {
      for (var image in storedImages) {
        selectedImages.add(File(image.imagePath));
      }
    }
    setState(() {
      _selectedImages = selectedImages;
    });
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
    if (_selectedImages.length != 1) {
      setState(() {
        File temp = _selectedImages[index];
        _selectedImages.removeAt(index);
        _selectedImages.insert(index - 1, temp);
      });
    }
  }

  Future _moveImageDown(int index) async {
    if (_selectedImages.length != 1) {
      setState(() {
        File temp = _selectedImages[index];
        _selectedImages.removeAt(index);
        _selectedImages.insert(index + 1, temp);
      });
    }
  }

  Future _deleteImage(int index) async {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _done() async {
    // Save images before proceeding
    _imagesDao.deleteImagesOfEvent(widget.eventId);
    for (var i = 0; i < _selectedImages.length; i++) {
      final savedPath = await saveImage(_selectedImages[i], '${Random(2)}.png');
      _imagesDao.createImage(savedPath, widget.eventId);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RefineScanScreen(selectedImages: _selectedImages),
      ),
    );
  }

  Future<String> saveImage(File imageFile, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final savedImage = await imageFile.copy('${dir.path}/$filename');
    return savedImage.path;
  }

  Future<void> _exitScreen() async {
    // Save images and associate with current event
    _imagesDao.deleteImagesOfEvent(widget.eventId);
    for (var i = 0; i < _selectedImages.length; i++) {
      final savedPath =
          await saveImage(_selectedImages[i], '${Random(2).hashCode}.png');
      _imagesDao.createImage(savedPath, widget.eventId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            await _exitScreen();
          }
        },
        child: Scaffold(
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
          body: _selectedImages.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Take a single or multiple photos of your receipt or choose from your photo gallery',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : SelectedImagesViewer(
                  selectedImages: _selectedImages,
                  onMoveUp: _moveImageUp,
                  onMoveDown: _moveImageDown,
                  onDelete: _deleteImage,
                  isEditable: true,
                ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: _selectedImages.isEmpty
                ? [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.photo), label: 'Gallery'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.camera_alt), label: 'Camera'),
                  ]
                : [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.add_photo_alternate),
                        label: 'Gallery'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.add_a_photo), label: 'Camera'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.check), label: 'Done')
                  ],
            onTap: (index) {
              setState(() => _currentIndex = index);
              if (index == 0) {
                _pickImageFromGallery();
              } else if (index == 1) {
                _pickImageFromCamera();
              } else if (index == 2) {
                _done();
              }
            },
          ),
        ));
  }
}
