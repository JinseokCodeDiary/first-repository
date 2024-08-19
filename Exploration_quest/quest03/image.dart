import 'package:flutter/material.dart';
import 'merge.dart';

class ImageSelectionPage extends StatefulWidget {
  @override
  _ImageSelectionPageState createState() => _ImageSelectionPageState();
}

class _ImageSelectionPageState extends State<ImageSelectionPage> {
  String? _foregroundImage;
  String? _backgroundImage;

  Future<void> _navigateToImageListPage(bool isForeground) async {
    final selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageListPage(isForeground: isForeground),
      ),
    );

    if (selectedImage != null) {
      setState(() {
        if (isForeground) {
          _foregroundImage = selectedImage;
        } else {
          _backgroundImage = selectedImage;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI 합성')),
      body: SingleChildScrollView(  // 여기에 스크롤을 추가
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_foregroundImage != null) Image.asset(_foregroundImage!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _navigateToImageListPage(true),
                child: Text('인물 선택'),
              ),
              SizedBox(height: 20),
              if (_backgroundImage != null) Image.asset(_backgroundImage!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _navigateToImageListPage(false),
                child: Text('배경 선택'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_foregroundImage != null && _backgroundImage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MergePage(
                          foregroundImage: _foregroundImage!,
                          backgroundImage: _backgroundImage!,
                        ),
                      ),
                    );
                  }
                },
                child: Text('합성'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageListPage extends StatelessWidget {
  final bool isForeground;

  ImageListPage({required this.isForeground});

  final List<String> _foregroundImagePaths = [
    'image/ex_project_person.jpg',
  ];

  final List<String> _backgroundImagePaths = [
    'image/background1.jpg',
    'image/background2.jpg',
    'image/background3.jpg',
    'image/background4.jpg',
    'image/background5.jpg',
    'image/background6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final imagePaths = isForeground ? _foregroundImagePaths : _backgroundImagePaths;

    return Scaffold(
      appBar: AppBar(title: Text(isForeground ? '인물 선택' : '배경 선택')),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = imagePaths[index];
          return ListTile(
            leading: Image.asset(imagePath, width: 50, height: 50),
            title: Text(imagePath.split('/').last),
            onTap: () {
              Navigator.pop(context, imagePath);
            },
          );
        },
      ),
    );
  }
}
