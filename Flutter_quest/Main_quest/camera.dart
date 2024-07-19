import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail1.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? imageFile;
  final TextEditingController _textController = TextEditingController();
  String? _description;
  String apiUrl = "https://3f71-175-205-125-72.ngrok-free.app"; // API 엔드포인트를 설정하세요

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        controller = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );
        controller?.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    if (controller!.value.isTakingPicture) {
      return;
    }

    try {
      XFile picture = await controller!.takePicture();
      if (mounted) {
        setState(() {
          imageFile = picture;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> savePicture() async {
    if (imageFile == null || _description == null || _description!.isEmpty) {
      return;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final String dirPath = '${directory.path}/pictures';
      await Directory(dirPath).create(recursive: true);

      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File newImage = await File(imageFile!.path).copy(filePath);

      final String descriptionFilePath = '$filePath.txt';
      final File descriptionFile = File(descriptionFilePath);
      await descriptionFile.writeAsString(_description!);

      setState(() {
        imageFile = null;
        _textController.clear();
        _description = null;
      });

      print('Picture saved to $filePath with description $descriptionFilePath');

      // 이미지 파일과 설명을 API로 전송
      await uploadPicture(newImage, _description!);
    } catch (e) {
      print('Failed to save picture: $e');
    }
  }

  Future<void> uploadPicture(File image, String description) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['description'] = description;
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Picture uploaded successfully');
      } else {
        print('Failed to upload picture. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Camera'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기 버튼 클릭 시 이전 페이지로 돌아가기
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: CameraPreview(controller!),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: takePicture,
            child: Text('사진 찍기'),
          ),
          if (imageFile != null) ...[
            Image.file(File(imageFile!.path)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: '정보 입력'),
                onChanged: (value) {
                  _description = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: savePicture,
              child: Text('저장'),
            ),
          ],
        ],
      ),
    );
  }
}
