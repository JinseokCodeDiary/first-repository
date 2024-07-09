import 'package:flutter/material.dart';
import 'User.dart';

class CatScreen extends StatelessWidget{
  @override

    Widget build(BuildContext context){
      return MaterialApp(
        home : Scaffold(
          appBar: AppBar(
            title: Text('FirstPage'),
            leading: const Icon(Icons.flutter_dash, color: Colors.black, size: 30,),
          ),
          body: Container(
            color: Colors.cyan,
            child: Center(child: Column(
              children: [Text('FirstPage', style: TextStyle(color: Colors.white, fontSize: 30),),
              Image.network(
                            'https://images.ctfassets.net/nx3pzsky0bc9/2xOR5jtDFS9EzPw3WmmlHC/3113cc789ef08ef32ec754b55c47bede/Kitten_laying_in_pink_bed.jpeg',
                            height: 300, // 이미지 높이
                            width: 300,  // 이미지 너비
                          ),
                          
              ElevatedButton(onPressed: ()async{
                final result = await Navigator.pushNamed(context, '/DetailScreen', arguments: {"arg1" : false,});
                print('result : ${"arg1"}');}, child: Text('next'))
                ]),),),
          )
          );
    }
}