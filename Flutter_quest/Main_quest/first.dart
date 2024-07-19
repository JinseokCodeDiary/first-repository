//어플의 첫화면
//어플을 대표할 수 있는 이미지와 갤러리, 카메라기능 선택 버튼으로 구성
import 'package:flutter/material.dart';
import 'camera.dart';
import 'detail1.dart';
import 'home.dart';
import 'dart:async';


class First extends StatelessWidget{
  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plant Disease Classifier'),
          leading: Icon(Icons.eco),),
      body: Container(
        child: Column(
          children: [
            Container(color: Colors.white,
              child :
              Image.asset(
                'images/main.jpg', width: 300,height: 300,)
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(
                      context, '/HomeScreen');
                      },
                      
          child:
          Text(
            '기록'),
            ),
          SizedBox(height: 20),

            ElevatedButton(onPressed: (){
              Navigator.pushNamed(
                context, '/Camera');
          },
          child: Text('카메라'),)
          ],
          ),
          ),

    );
    }
}
