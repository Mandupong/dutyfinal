import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Dropdown.dart';

void main() {
  runApp(MaterialApp(
    home: HRScreen(),
  ));
}

class HRScreen extends StatefulWidget {
  @override
  _HRScreenState createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  List<DailyShifts>? shifts;
  Map<String, int> shiftCounts = {'A': 0, 'B': 0, 'C': 0, 'D': 0};
  Map<String, Map<String, int>> teamShiftCountsDisplay = {};
  Map<String, Map<String, int>> teamShiftTypeCounts = {
    'A': {'D': 0, 'E': 0, 'N': 0},
    'B': {'D': 0, 'E': 0, 'N': 0},
    'C': {'D': 0, 'E': 0, 'N': 0},
    'D': {'D': 0, 'E': 0, 'N': 0},
  };

  List<DailyShifts> generateRandomShiftsForWeek(int year, int month, int startDay) {
    List<DailyShifts> weeklyShifts = [];
    DateTime startDate = DateTime(year, month, startDay);
    Random random = Random();

    final List<String> teams = ['A', 'B', 'C', 'D'];
    final List<String> shiftTypes = ['D', 'E', 'N'];

    Map<String, int> teamWorkDays = Map.fromIterable(
        teams, key: (e) => e, value: (e) => 0);
    Map<String, int> teamTotalWorkDays = Map.fromIterable(
        teams, key: (e) => e, value: (e) => 0);
    Map<String, DateTime> lastNightShift = Map.fromIterable(
        teams, key: (e) => e, value: (e) => DateTime(200));
    Map<String, DateTime> lastEveShift = Map.fromIterable(
        teams, key: (e) => e, value: (e) => DateTime(200));
    Map<String, DateTime> lastOffDay = Map.fromIterable(
        teams, key: (e) => e, value: (e) => DateTime(200));

    Map<String, Map<String, int>> teamShiftCounts = {
      for (var team in teams) team: {'D': 0, 'E': 0, 'N': 0}
    };
    Map<String, DateTime> teamOffDays = {};

    setState(() {
      teamShiftCountsDisplay = Map.from(teamShiftCounts);
    });


    for (int i = 0; i < 28; i++) {
      DateTime date = startDate.add(Duration(days: i));
      List<Shift> dayShifts = [];
      List<String> teamsWorkedToday = [];



        for (String shiftType in shiftTypes) {
        List<String> availableTeams = teams.where((team) {
          bool WantedoffA = (team == "A" && teamOffDay != null && date.isAtSameMomentAs(teamOffDay!));
          bool WantedoffB = (team == "B" && teamOffDay2 != null && date.isAtSameMomentAs(teamOffDay2!));
          bool WantedoffC = (team == "C" && teamOffDay3 != null && date.isAtSameMomentAs(teamOffDay3!));
          bool WantedoffD = (team == "D" && teamOffDay4 != null && date.isAtSameMomentAs(teamOffDay4!));
          bool isAfterLastNightShift = lastNightShift[team]!.add(Duration(days: 1)).isBefore(date); //N-N용 bool
          bool isAfterLastNightShift2 = lastNightShift[team]!.add(Duration(days: 2)).isBefore(date); //N-OFF-@용 bool
          bool isAfterLastEveShift = lastEveShift[team]!.add(Duration(days: 1)).isBefore(date); //E-D용 bool
          bool isDayAfterOff = lastOffDay[team]!.add(Duration(days: 2)).isBefore(date); //최대한 2 OFF 부여
          bool isEligibleAfterNightShift = shiftType == 'N' || (shiftType != 'N' && isAfterLastNightShift); //N-N
          bool isEligibleAfterEveShift = shiftType != 'D' || (shiftType == 'D' && isAfterLastEveShift); //N-E
          bool isEligibleNOD = shiftType != 'D' || (shiftType == 'D' && isAfterLastNightShift2); //E-D

          return (teamWorkDays[team]! < 5) // 주 5일
              && !WantedoffA
              && !WantedoffB
              && !WantedoffC
              && !WantedoffD
              && (teamShiftCounts[team]![shiftType]!) < 7 // 7-7-7
              && !teamsWorkedToday.contains(team) //당일 1근무
              && isEligibleAfterNightShift
              && isEligibleAfterEveShift
              && isDayAfterOff
              && isEligibleNOD;
        }).toList();

        if (availableTeams.isEmpty) {
          dayShifts.add(Shift(team: '[ ]', shiftType: Shift.emptyShift));
          continue;
        }

        String team = availableTeams[random.nextInt(availableTeams.length)];
        dayShifts.add(Shift(team: team, shiftType: shiftType));
        teamsWorkedToday.add(team);

        teamShiftCounts[team]![shiftType] =
            (teamShiftCounts[team]![shiftType] ?? 0) + 1;
        teamWorkDays[team] = (teamWorkDays[team] ?? 0) + 1;
        teamTotalWorkDays[team] = teamTotalWorkDays[team]! + 1;

        if (shiftType == 'N') {lastNightShift[team] = date;}
        if (shiftType == 'E') {lastEveShift[team] = date;}
        if (shiftType != 'N' && shiftType != 'E' && shiftType != 'D') {lastOffDay[team] = date;} //오프날 업뎃
      }

      teamWorkDays.keys.where((team) => !teamsWorkedToday.contains(team))
          .forEach((team) {teamWorkDays[team] = 0;});

      weeklyShifts.add(DailyShifts(date: date, shifts: dayShifts));}

    for (var team in teams) {
      printShiftCounts(teamShiftCounts[team]!, team);
    }
    return weeklyShifts;
  }


  void printShiftCounts(Map<String, int> shiftCounts, String teamName) {
    print('팀 $teamName의 근무 횟수:');
    shiftCounts.forEach((shiftType, count) {
      print('$shiftType 근무: $count 번');
    });
  }

  Widget buildShiftCounts(Map<String, int> shiftCounts, String teamName) {
    return Container(
      margin: EdgeInsets.only(right: 10.0, left: 25.0,top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '팀 $teamName :',
            style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14),
          ),
          ...shiftCounts.entries.map((entry) =>
              Text(
                '${entry.key} : ${entry.value} 번',
                style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14),
              ),
          ).toList(),
        ],
      ),
    );
  }
  DateTime? teamOffDay;
  void handleSelectedDay(int? day) {
    setState(() {
      // 선택된 날짜를 DateTime 형식으로 저장
      if (day != null) {
        teamOffDay = DateTime(2023, 1, day); // 예시: 2023년 1월
      }
    });
  }
  DateTime? teamOffDay2;
  void handleSelectedDay2(int? day) {
    setState(() {
      // 선택된 날짜를 DateTime 형식으로 저장
      if (day != null) {
        teamOffDay2 = DateTime(2023, 1, day); // 예시: 2023년 1월
      }
    });
  }
  DateTime? teamOffDay3;
  void handleSelectedDay3(int? day) {
    setState(() {
      // 선택된 날짜를 DateTime 형식으로 저장
      if (day != null) {
        teamOffDay3 = DateTime(2023, 1, day); // 예시: 2023년 1월
      }
    });
  }
  DateTime? teamOffDay4;
  void handleSelectedDay4(int? day) {
    setState(() {
      // 선택된 날짜를 DateTime 형식으로 저장
      if (day != null) {
        teamOffDay4 = DateTime(2023, 1, day); // 예시: 2023년 1월
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height:40), // 칸막이용
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TDropdownSA(onSelectedDay: handleSelectedDay),Spacer(),
                TDropdownSB(onSelectedDay2: handleSelectedDay2),Spacer(),
                TDropdownSC(onSelectedDay3: handleSelectedDay3),Spacer(),
                TDropdownSD(onSelectedDay4: handleSelectedDay4),Spacer(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0), // 하단에 10.0 픽셀 마진 추가
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  shifts = generateRandomShiftsForWeek(2023, 1, 1);
                  // 각 팀별 근무 횟수 데이터를 업데이트
                  teamShiftTypeCounts = teamShiftTypeCounts;
                });
              },
              child: Text('랜덤 생성하기', style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF064789)), // 버튼의 배경색 설정
              ),
            ),
          ),
          Expanded(
            child: shifts != null && shifts!.isNotEmpty
                ? buildShiftsListView()
                : Center(child: Text("근무표가 나타날 공간입니다.", style: TextStyle(fontFamily: 'DungGeunMo', fontSize: 14)),
          ),
          )],
      ),
    );
  }


  Widget buildShiftsListView() {
    int itemsPerRow = 7;
    int totalRows = (shifts!.length / itemsPerRow).ceil();

    return ListView.builder(
      itemCount: totalRows + 1,
      itemBuilder: (context, rowIndex) {
        if (rowIndex == totalRows) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: teamShiftCountsDisplay.entries.map((entry) {
                return buildShiftCounts(entry.value, entry.key);
              }).toList(),
            ),
          );
        }
        List<Widget> rowItems = [];
        for (int i = 0; i < itemsPerRow; i++) {
          int index = rowIndex * itemsPerRow + i;

          // 빈 컨테이너 추가
          if (index >= shifts!.length) {
            rowItems.add(Expanded(child: Container()));
          } else {
            final shift = shifts![index];
            rowItems.add(
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat('dd').format(shift.date)),
                      shift.shiftsRichText(), // 근무 정보 표시
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return Column(
          children: [
            Row(children: rowItems),
            if (rowIndex < totalRows) Divider(),
          ],
        );
      },
    );
  }
}

class DailyShifts {
  final DateTime date;
  final List<Shift> shifts;

  DailyShifts({required this.date, required this.shifts});

  bool get isEmpty => shifts.every((shift) => shift.isEmpty);

  RichText shiftsRichText() {
    List<TextSpan> spans = [];

    for (var shift in shifts) {
      spans.add(
        TextSpan(
          text: '${shift.team}',
          style: TextStyle(
            color: _getColorForTeam(shift.team), // 팀 색상 지정
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      // shifts 엔터 넣기
      spans.add(TextSpan(text: '\n', style: TextStyle(color: Colors.red)));
    }

    // 마지막 쉼표 제거
    if (spans.isNotEmpty) {
      spans.removeLast();
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 16, color: Colors.black), // 기본
      ),
    );
  }

  Color _getColorForTeam(String team) {
    switch (team) {
      case 'A':
        return Colors.red;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.green;
      case 'D':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}

class Shift {
  final String team;
  final String shiftType;
  static const String emptyShift = '[ ]'; // 빈칸 글

  Shift({required this.team, required this.shiftType});

  // 빈칸 여부를 확인하는 메서드
  bool get isEmpty => shiftType == emptyShift;
}


