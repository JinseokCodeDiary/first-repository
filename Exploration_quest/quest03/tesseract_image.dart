import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class TesseractImage extends StatefulWidget {
  final FlutterVision vision;
  const TesseractImage({super.key, required this.vision});

  @override
  State<TesseractImage> createState() => _TesseractImageState();
}

class _TesseractImageState extends State<TesseractImage> {
  late List<Map<String, dynamic>> tesseractResults = [];
  File? imageFile;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadTesseractModel().then((value) {
      setState(() {
        isLoaded = true;
        tesseractResults = [];
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            imageFile != null ? Image.file(imageFile!) : const SizedBox(),
            tesseractResults.isEmpty
                ? const SizedBox()
                : Align(child: Text(tesseractResults[0]["text"])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: pickImage,
                  child: const Text("Pick an image"),
                ),
                ElevatedButton(
                  onPressed: tesseractOnImage,
                  child: const Text("Get Text"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadTesseractModel() async {
    await widget.vision.loadTesseractModel(
      args: {
        'psm': '11',
        'oem': '1',
        'preserve_interword_spaces': '1',
      },
      language: 'spa',
    );
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
    }
  }

  tesseractOnImage() async {
    tesseractResults.clear();
    Uint8List byte = await imageFile!.readAsBytes();
    final result = await widget.vision.tesseractOnImage(bytesList: byte);
    if (result.isNotEmpty) {
      setState(() {
        tesseractResults = result;
      });
    }
  }
}
