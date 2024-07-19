import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'photo.dart';
import 'home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  String treatmentInfo = ""; // 처치 완료 정보를 저장할 변수
  String currentId = "";
  TextEditingController urlController = TextEditingController(); // URL을 입력 받는 컨트롤러
  String url = "https://4c57-175-205-125-72.ngrok-free.app/";

  @override
  void initState() {
    super.initState();
    // 페이지가 로드될 때 저장된 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedData();
    });
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedInfo = prefs.getString('treatmentInfo_$currentId');
    setState(() {
      treatmentInfo = savedInfo ?? ''; // 저장된 정보 로드
    });
  }

  Future<void> _saveData(String info) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('treatmentInfo_$currentId', info); // 항목별 정보 저장
  }

  Future<void> fetchData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse(url + endpoint),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = endpoint == "sample"
              ? "병명: ${data['predicted_label']}"
              : "확률: ${data['prediction_score']}";
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('병명'),
                onTap: () {
                  Navigator.pop(context);
                  fetchData("sample"); // 데이터 가져오기
                },
              ),
              ListTile(
                title: Text('처방'),
                onTap: () {
                  Navigator.pop(context);
                  fetchData("prescription"); // 데이터 가져오기
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInputDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("처치 정보 입력"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "처치 정보를 입력하세요"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("저장"),
              onPressed: () {
                final info = _controller.text;
                setState(() {
                  treatmentInfo = info;
                });
                _saveData(info); // 데이터 저장
                Navigator.of(context).pop();
              },
            ),
                        TextButton(
              child: Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    currentId = args['arg1']; // 현재 항목 ID를 저장
    final id = args['arg1'];
    final imageUrl = args['arg2'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기 버튼 클릭 시 이전 페이지로 돌아가기
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: 500,
              height: 500,
            ),
            Text('$id'),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            // ElevatedButton(
            //   onPressed: () => fetchData("sample"), // 진단 데이터 가져오기
            //   child: Text("진단"),
            // ),
            // SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _showBottomSheet(context); // 처방 데이터 가져오기
              },
              child: Text('ai'),
            ),
            
            ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showInputDialog, // 처치 완료 정보 입력 다이얼로그 열기
              child: Text("해결(약품, 제조사)방법 입력"),
            ),
            Text(
              result,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "해결 기록: $treatmentInfo",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}