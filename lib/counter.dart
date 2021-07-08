import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class CounterPage extends StatefulWidget {
  CounterPage({Key key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // List<Diary> diary = [
  //   Diary(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기"),
  //   Diary(id: 2, title: "헬스 2시간", done: false, memo: "어깨운동"),
  // ];
  List<String> emoji = ["img/happy1.png", "img/soso3.png", "img/sad2.png"];
  List<String> text = ["오늘은 날씨가 좋아요!\n밖으로 산책을 나가보는건 어떨까요?", "미세먼지가 조금 있어요.\n마스크를 착용하세요", "미세먼지가 너무 많아요.\n외출을 자제하세요"];
  List<Color> colors = [Color(0xFF68CA44), Color(0xFFF7C60C), Color(0xFFF22B39)];
  int _selectedIndex = 0;
  String location = "구로구";
  int count1 = 0;
  int count2 = 0;
  int max = 11;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(child: Text("종료 점수 : $max점", style: TextStyle(color: Colors.black),),
          onTap: (){
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return _buildBottomPicker(
                      _buildScorePicker(max));
                });
          },
        ),
        actions: [
          TextButton(child: Text("리셋", style: TextStyle(color: Colors.redAccent),), onPressed: (){
            setState(() {
              count1 = 0;
              count2 = 0;
            });
          },)
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        // color: colors[_selectedIndex],
        child: Column(
          children: [
            Container(height: 100),
            Text("패스트 캠퍼스 탁구 대회", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),),
            Container(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("패스트 대학"),
                Text("캠퍼스 대학"),
              ],
            ),
        Container(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("$count1", style: TextStyle(fontSize: 24),),
                Text("$count2", style: TextStyle(fontSize: 24),),
              ],
            ),
            Container(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(child: Container(
                  child: Text("+1", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue,
                ),
                  onTap: (){
                  setState(() {
                    count1++;
                    if(count1 >= max){
                      showDialog(
                        context: context,
                        builder: (ctx){
                          return AlertDialog(
                            title: Text("패스트 대학이 이겼습니다!!"),
                            content: Text("패스트 대학 결승 진출!!"),
                          );
                        }
                      );
                    }
                  });
                  },
                ),
                InkWell(child: Container(
                  child: Text("-1", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue,
                ),
                  onTap: (){
                    setState(() {
                      count1--;
                    });
                  },
                ),
                InkWell(child: Container(
                  child: Text("+1", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue,
                ),
                  onTap: (){
                    setState(() {
                      count2++;
                      if(count2 >= max){
                        showDialog(
                            context: context,
                            builder: (ctx){
                              return AlertDialog(
                                title: Text("캠퍼스 대학이 이겼습니다!!"),
                                content: Text("캠퍼스 대학 결승 진출!!"),
                              );
                            }
                        );
                      }
                    });
                  },
                ),
                InkWell(child: Container(
                  child: Text("-1", style: TextStyle(color: Colors.white),),
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue,
                ),
                  onTap: (){
                    setState(() {
                      count2--;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 6.0, bottom: 50),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildScorePicker(int score) {
//    var localizations = CupertinoLocalizations.of(context);
    return CupertinoPicker(
      scrollController:
      FixedExtentScrollController(initialItem: score),
      itemExtent: 40,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (int index) {
        setState(() {
          max = index;
        });
      },
      children: List<Widget>.generate(100, (int index) {
        return Semantics(
          excludeSemantics: true,
          child: Container(
            child: Container(
              // Adds some spaces between words.
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text("$index점",
                  style: TextStyle()),
            ),
          ),
        );
      }),
    );
  }
}


class LocationPage extends StatefulWidget {
  final String location;
  LocationPage({Key key, this.location}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(""),
          actions: [
          ],
        ),
        body: ListView(
          children: [
            ListTile(title: Text("성북구"), onTap: (){
              Navigator.of(context).pop("성북구");
            },),
            ListTile(title: Text("동작구"), onTap: (){
              Navigator.of(context).pop("동작구");
            },),
            ListTile(title: Text("성동구"), onTap: (){
              Navigator.of(context).pop("성동구");
            },),
            ListTile(title: Text("마포구"), onTap: (){
              Navigator.of(context).pop("마포구");
            },),
            ListTile(title: Text("강남구"), onTap: (){
              Navigator.of(context).pop("강남구");
            },),
          ],
        ));
  }

  // 좌표 to xy

}

class Utils {
  static String makeTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }
  static int getFormatTime(DateTime date) {
    return int.parse(
        "${date.year}${Utils.makeTwoDigit(date.month)}${Utils.makeTwoDigit(date.day)}");
  }

  static String getFormatTimeWithHour(DateTime date) {
    return "${date.year}${Utils.makeTwoDigit(date.month)}${Utils.makeTwoDigit(date.day)}${Utils.makeTwoDigit(date.hour)}${Utils.makeTwoDigit(date.minute)}";
  }

  static DateTime stringToDateTime(String date) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(4, 6));
    int day = int.parse(date.substring(6, 8));

    return DateTime(year, month, day);
  }
}