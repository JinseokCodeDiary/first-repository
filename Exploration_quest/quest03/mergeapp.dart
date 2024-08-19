import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class MergePage extends StatefulWidget {
  final String foregroundImage;
  final String backgroundImage;

  MergePage({required this.foregroundImage, required this.backgroundImage});

  @override
  _MergePageState createState() => _MergePageState();
}

class _MergePageState extends State<MergePage> {
  Uint8List? _mergedImage;

  @override
  void initState() {
    super.initState();
    _mergeImages();
  }

  Future<void> _mergeImages() async {
    try {
      // 서버로 POST 요청을 보내 이미지 합성을 요청합니다.
      final request = http.MultipartRequest('POST', Uri.parse('https://5a5d-34-168-83-150.ngrok-free.app'));

      // 인물과 배경 이미지를 요청에 추가합니다.
      request.files.add(await http.MultipartFile.fromPath('foreground', widget.foregroundImage));
      request.files.add(await http.MultipartFile.fromPath('background', widget.backgroundImage));

      // 서버로부터의 응답을 기다립니다.
      final response = await request.send();

      if (response.statusCode == 200) {
        // 응답에서 합성된 이미지 데이터를 가져옵니다.
        final mergedImageBytes = await response.stream.toBytes();

        setState(() {
          _mergedImage = mergedImageBytes;
        });
      } else {
        print('Image merge failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error merging images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('합성 결과')),
      body: Center(
        child: _mergedImage != null
            ? Image.memory(_mergedImage!) // 합성된 이미지를 표시
            : CircularProgressIndicator(), // 이미지가 로딩 중일 때 로딩 표시
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(); // 이전 화면으로 돌아가기
        },
        child: Icon(Icons.close),
      ),
    );
  }
}
