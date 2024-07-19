import 'package:flutter/material.dart';
import 'package:gridview/detail1.dart';
import 'Photo.dart';
import 'detail1.dart';
import 'home.dart';
import 'first.dart';
import 'camera.dart';
import 'dart:async';
void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Photo> Photos = [
    Photo(id: 'id', url:  'url', title: 'title')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/First',
      routes: {
        '/First' : (context) => First(),
        '/HomeScreen' : (context) => Home(),
        '/DetailScreen' : (context) => MyHomePage(),
        '/Camera' : (context) => CameraPage(),}
    );
  }
}
