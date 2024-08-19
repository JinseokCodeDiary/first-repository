import 'package:flutter/material.dart';
import 'package:shutter/mdels/tesseract_image.dart';
import 'package:shutter/mdels/yolo_image_v8seg.dart';
import 'package:shutter/mdels/yolo_video.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:shutter/mdels/yolov5.dart';
import 'package:shutter/mdels/yolov8.dart';

// Used models
enum Options { none, imagev5, imagev8, imagev8seg, frame, tesseract, vision }

Widget task(Options option, FlutterVision vision) {
  if (option == Options.frame) {
    return YoloVideo(vision: vision);
  }
  if (option == Options.imagev5) {
    return YoloImageV5(vision: vision);
  }
  if (option == Options.imagev8) {
    return YoloImageV8(vision: vision);
  }
  if (option == Options.imagev8seg) {
    return YoloImageV8Seg(vision: vision);
  }
  if (option == Options.tesseract) {
    return TesseractImage(vision: vision);
  }
  return const Center(child: Text("Choose Task"));
}
