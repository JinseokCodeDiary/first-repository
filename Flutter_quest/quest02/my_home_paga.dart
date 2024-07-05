import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('플러터 앱 만들기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
          leading: const Icon(Icons.flutter_dash, color: Colors.white, size: 30,),

        ),
        body: Center(child: Column(children: [
          SizedBox(height: 400,),
          GestureDetector(
            onTap: () => print('버튼이 눌렸습니다.'),
            child :Container(color : Colors.blue, width: 100, height:100, 
            child: const Center( child :Text('Text', style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),))),
          
          SizedBox(height: 20,),

          Container(
            width: 300, height: 300, color: Colors.blue,
            child: Stack(
              children: [Positioned(child: Container(width: 240, height: 240, color: Colors.white,)),
              Positioned(child: Container(width: 180, height: 180, color: Colors.black,)),
              Positioned(child: Container(width: 120, height: 120, color: Colors.red,)),
              Positioned(child: Container(width: 60, height: 60, color: Colors.green,)),
              ],
            )
          ),
          ],

            ),
            ),
          
        
      );
    }
  }
