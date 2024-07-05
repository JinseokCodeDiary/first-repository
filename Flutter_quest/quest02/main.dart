import 'package:flutter/material.dart';
import '/my_home_paga.dart';

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
