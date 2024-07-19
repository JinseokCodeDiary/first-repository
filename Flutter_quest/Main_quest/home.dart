//갤러리를 선택했을 때 출력되는 화면
//그리드뷰로 구성, 각 그리드가 elevatedbutton

import 'package:flutter/material.dart';
import 'package:gridview/main.dart';
import 'detail1.dart';
import 'Photo.dart';
import 'package:http/http.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Photo> photos = [
    Photo(id: '1번', url: 'images/plant1.jpg', title: '1번째 기록'),
    Photo(id: '2번', url: 'images/plant2.jpg', title: '2번째 기록'),
    Photo(id: '3번', url: 'images/plant3.jpg', title: '3번째 기록'),
    Photo(id: '4번', url: 'images/plant4.jpg', title: '4번째 기록'),
    Photo(id: '5번', url: 'images/plant5.jpg', title: '5번째 기록'),
    Photo(id: '6번', url: 'images/plant6.jpg', title: '6번째 기록'),
  ];

  List<Photo> filteredPhotos = []; // 초기화 추가
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPhotos = photos;
  }

  void _filterPhotos(String query) {
    final filtered = photos.where((photo) {
      final titleLower = photo.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredPhotos = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: '검색',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => _filterPhotos(query),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredPhotos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //한 행 2개 배치
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(filteredPhotos[index].title),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    '/DetailScreen',
                                    arguments: {
                                      "arg1": filteredPhotos[index].id,
                                      "arg2": filteredPhotos[index].url,
                                    },
                                  );
                                  print(result); // Optional: Handle the result if needed
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        filteredPhotos[index].url,
                                        width: 400,
                                        height: 400,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              scrollDirection: Axis.vertical, // 스크롤 방향 수직
            ),
          ),
        ],
      ),
    );
  }
}