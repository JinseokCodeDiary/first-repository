# AIFFEL Campus Code Peer Review

- 코더 : 박진석
- 리뷰어 : 서은재

# PRT(Peer Review Template)

- [v] **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 네 잘 작성되었습니다. pushNamed를 사용하여 다음 페이지로 넘어가게 코드를 구현하였습니다.
```
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
```
    

- [v] **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
    - 주석이 작성되어 있습니다~
```
  height: 300, // 이미지 높이
  width: 300,  // 이미지 너비
```

- [v] **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는
  “새로운 시도 및 추가 실험”을 해봤나요?**
    - 여러 시도와 고민을 시도하고 기록한 흔적을 볼 수 있었습니다.
```
  //회고 이미지 에셋을 불러오기 실패해서 네트워크에서 불러오기로 이미지를 넣었습니다.
```

- [v] **4. 회고를 잘 작성했나요?**
    - 회고가 작성되어있습니다.
```
  //아이콘도 고양이로 바꾸려 패키지를 설치해서 사용하려고 했으나 잘 되지 않아 기본이미지로 대신했습니다.
```

- [v] **5. 코드가 간결하고 효율적인가요?**
    - 코드가 간결하고 꼭 필요한 코드가 작성되어있습니다. 고생하셨습니다.


# 참고 링크 및 코드 개선

```
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.

AppBar의 TEXT를 가운데로 놓는 방법들이 여러가지가 있겠지만
centerTitle: true, // 텍스트를 가운데 정렬하는 방법이 있다고 하네요!
(GPT)

```
