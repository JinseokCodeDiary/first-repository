import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shutter/widgets/tasks.dart';

import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';

// Used camera list
late List<CameraDescription> cameras;

main() async {
  // camera plugin initialization
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterVision vision;
  Options option = Options.none;

  // initialization of FlutterVision
  @override
  void initState() {
    super.initState();
    vision = FlutterVision();
  }

  @override
  void dispose() async {
    super.dispose();
    await vision.closeTesseractModel();
    await vision.closeYoloModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: task(option, vision),
      floatingActionButton: SpeedDial(
        // margin bottom
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.black12, //background color of button
        foregroundColor: Colors.white, //font color, icon color in button
        activeBackgroundColor:
            Colors.deepPurpleAccent, //background color when menu is expanded
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        buttonSize: const Size(56.0, 56.0),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.video_call),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Yolo on Frame',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              setState() {
                option = Options.frame;
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'YoloV8seg on Image',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                option = Options.imagev8seg;
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'YoloV8 on Image',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                option = Options.imagev8;
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'YoloV5 on Image',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                option = Options.imagev5;
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.text_snippet_outlined),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Tesseract',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              setState(
                () {
                  option = Options.tesseract;
                },
              );
            },
          ),
          // SpeedDialChild(
          //   child: const Icon(Icons.document_scanner),
          //   foregroundColor: Colors.white,
          //   backgroundColor: Colors.green,
          //   label: 'Vision',
          //   labelStyle: const TextStyle(fontSize: 18.0),
          //   onTap: () {
          //     setState(() {
          //       option = Options.vision;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
