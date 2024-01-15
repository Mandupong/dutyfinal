import 'package:flutter/material.dart';
import 'THcode.dart' ;
import 'Inform.dart' ;

class TDropdownSA extends StatefulWidget {
  final Function(int?) onSelectedDay; // 콜백 함수 정의

  TDropdownSA({Key? key, required this.onSelectedDay}) : super(key: key);

  @override
  _TDropdownSAState createState() => _TDropdownSAState();
}

class _TDropdownSAState extends State<TDropdownSA> {
  int? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 105.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
              'A',
              style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)
          ),
          DropdownButton<int>(
            value: selectedDay,
            hint: Text('신청 오프', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
            onChanged: (int? newValue) {
              setState(() {
                selectedDay = newValue;
              });
              widget.onSelectedDay(newValue); // 선택된 날짜를 상위 위젯으로 전달
            },
            items: List.generate(28, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value일' , style: (TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
              ));
            }).toList(),

          ),
        ],
      ),
    );
  }
}

class TDropdownSB extends StatefulWidget {
  final Function(int?) onSelectedDay2; // 콜백 함수 정의

  TDropdownSB({Key? key, required this.onSelectedDay2}) : super(key: key);

  @override
  _TDropdownSBState createState() => _TDropdownSBState();
}

class _TDropdownSBState extends State<TDropdownSB> {
  int? selectedDay2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 105.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
              'B',
              style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)
          ),
          DropdownButton<int>(
            value: selectedDay2,
            hint: Text('신청 오프', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
            onChanged: (int? newValue) {
              setState(() {
                selectedDay2 = newValue;
              });
              widget.onSelectedDay2(newValue); // 선택된 날짜를 상위 위젯으로 전달
            },
            items: List.generate(28, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value일' , style: (TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                  ));
            }).toList(),

          ),
        ],
      ),
    );
  }
}

class TDropdownSC extends StatefulWidget {
  final Function(int?) onSelectedDay3; // 콜백 함수 정의

  TDropdownSC({Key? key, required this.onSelectedDay3}) : super(key: key);

  @override
  _TDropdownSCState createState() => _TDropdownSCState();
}

class _TDropdownSCState extends State<TDropdownSC> {
  int? selectedDay3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 105.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
              'C',
              style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)
          ),
          DropdownButton<int>(
            value: selectedDay3,
            hint: Text('신청 오프', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
            onChanged: (int? newValue) {
              setState(() {
                selectedDay3 = newValue;
              });
              widget.onSelectedDay3(newValue); // 선택된 날짜를 상위 위젯으로 전달
            },
            items: List.generate(28, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value일' , style: (TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                  ));
            }).toList(),

          ),
        ],
      ),
    );
  }
}

class TDropdownSD extends StatefulWidget {
  final Function(int?) onSelectedDay4; // 콜백 함수 정의

  TDropdownSD({Key? key, required this.onSelectedDay4}) : super(key: key);

  @override
  _TDropdownSDState createState() => _TDropdownSDState();
}

class _TDropdownSDState extends State<TDropdownSD> {
  int? selectedDay4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 105.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
              'D',
              style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)
          ),
          DropdownButton<int>(
            value: selectedDay4,
            hint: Text('신청 오프', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
            onChanged: (int? newValue) {
              setState(() {
                selectedDay4 = newValue;
              });
              widget.onSelectedDay4(newValue); // 선택된 날짜를 상위 위젯으로 전달
            },
            items: List.generate(28, (index) => index + 1)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value일' , style: (TextStyle(fontFamily: 'DungGeunMo', fontSize: 13)),
                  ));
            }).toList(),

          ),
        ],
      ),
    );
  }
}