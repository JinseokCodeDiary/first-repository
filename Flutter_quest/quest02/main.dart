import 'package:flutter/material.dart';
import '/my_home_paga.dart'; // 두개의 dart파일을 사용하기 때문에 import

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
    Widget build(BuildContext context){
      return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home:  const MyHomePage(),
      );
    }
  }
// 팀원 덕분에 두개의 dart파일을 이용해서 깔끔하게 작성하는 것을 알게 되었고, 체계적으로 진행해서 하면서 배웠다.
