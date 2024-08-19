import 'package:flutter/material.dart';
import 'image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Merge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageSelectionPage(),
    );
  }
}
