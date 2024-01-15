import 'package:flutter/material.dart';
import 'THcode.dart' ;
import 'Inform.dart' ;
import 'package:fluttericon/rpg_awesome_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BG4.png'), fit: BoxFit.cover, ),),
          child: Align(
            alignment: Alignment(0, -0.8),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 140 ,
                  height: 26,
                  margin: EdgeInsets.only(top: 38.0, bottom: 6.0, right: 1.0),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarouselSliderPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE94F37),
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(RpgAwesome.dice_one, size: 20),
                        SizedBox(width: 1),
                        Text('  설명서', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 140 ,
                  height: 26,
                  margin: EdgeInsets.only(bottom: 6.0, right: 1.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HRScreen()
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0E6BA8),
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(RpgAwesome.dice_two, size: 20),
                        SizedBox(width: 3),
                        Text('  3조 2교대', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 140 ,
                  height: 26,
                  margin: EdgeInsets.only(bottom: 0.0, right: 1.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HRScreen()
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0E6BA8),
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(RpgAwesome.dice_three, size: 20),
                        SizedBox(width: 3),
                        Text('  4조 3교대', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:120), //위젯 space 용
              ],
            ),
          ),
        ));
  }
}
class THScreen extends StatefulWidget {
  THScreen(Object s);

  @override
  THScreenState createState() => THScreenState();}

class THScreenState extends State<THScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0E6BA8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '주의사항',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: ListView(
            children: <Widget> [
              Container(
                margin: EdgeInsets.only(top: 10, left: 5, bottom: 5), // 왼쪽 여백 설정
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration( // 배경색상을 위한 BoxDecoration
                      color: Color(0xFFFEFAE0), // 원하는 배경색상을 지정
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Color(0xFFBC6C25)), // 아이콘 추가
                        Text(
                          ' 즉, 교육용처럼 세세한 처치법이 들어있지 않습니다. \n 자세나 기본 지식을 미리 숙지하시고 \n 실제 상황에서 처치 단계를 참고하는 정도로 어플을 사용하세요.'
                          ,style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]));
  }
}
