import 'package:flutter/material.dart';

class ad extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
            title: Text('이벤트', style: TextStyle(fontSize: 30),),
            
          ),
          body: Container(
            color: Colors.cyan,
            child: Center(child: Column(
              children: [

              Container(child: 
              Image.network(
                            'https://res.heraldm.com/content/image/2024/07/04/20240704050351_0.jpg',
                            height: 300, // 이미지 높이
                            width: 300,  // 이미지 너비
                          ),
              ),
              Container(child:  
              Text('비프라구 와퍼 출시\n1. 제품명 : 클래식 비프라구 와퍼, 베이컨치즈 비프라구 와퍼 \n2.판매기간 : 24년 7월 4일(목) ~ 24년 9월 26일(수)\n유의사항\n*본 제품은 실제 이미지와 다를 수 있습니다.\n*본 제품은 밀, 대두, 우유, 돼지고기, 토마토, 쇠고기, 조개류,\n난류를 포함하고 있습니다.\n*일부 매장은 행사에서 제외될 수 있습니다.\n 4.제외 매장\n대명비발디점, 오션월드점, 대전현대아울렛점, 군산수송점'),
              ),
              
              ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, '/detail');
                  }, child: Text('킹오더 주문하러 가기'), )
              
              ]),
              ),),
    )
  );
  }
}