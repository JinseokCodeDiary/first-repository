import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  TextEditingController urlController =
      TextEditingController(); // URL을 입력 받는 컨트롤러
  String url = "https://f6ff-34-145-99-217.ngrok-free.app/";
  Future<void> fetchData() async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(url + "sample"), // 입력된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = "predicted_label: ${data['predicted_label']}";
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  } // URL을 입력 받는 컨트롤러

  Future<void> fetchData1() async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(url + "sample"), // 입력된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = "prediction_score: ${data['prediction_score']}";
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jellyfish Classifier"),
        leading: const Icon(Icons.flutter_dash, color: Colors.white, size: 30),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRne0oFiTpjdFzva5ERSLcI22CPveeCFAGtWetPWNAgiLuvhLiZ',
              height: 300, // 이미지 높이
              width: 300, // 이미지 너비
            ),
            // TextField(
            //   controller: urlController, // URL 입력을 위한 TextField
            //   decoration: InputDecoration(labelText: "URL 입력"), // 입력 필드의 라벨
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: fetchData,
                child: Text("결과보기"),
              ),
              ElevatedButton(
                onPressed: fetchData1,
                child: Text("예측확률"),
              )
            ]),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
//아이콘과 debug console에 출력은 완성하지 못했지만 배웠던 것을 응용해서 기본 동작을 구현하는데 어려움은 크게 없었다.
//추가적으로 아이콘 debugconsole 출력을 복습할 예정이다.
