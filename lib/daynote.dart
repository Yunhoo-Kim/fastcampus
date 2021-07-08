import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DayNotePage extends StatefulWidget {
  DayNotePage({Key key}) : super(key: key);

  @override
  _DayNotePageState createState() => _DayNotePageState();
}

class _DayNotePageState extends State<DayNotePage> {
  // List<Diary> diary = [
  //   Diary(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기"),
  //   Diary(id: 2, title: "헬스 2시간", done: false, memo: "어깨운동"),
  // ];
  List<String> emoji = ["img/happy_on.png", "img/soso_on.png", "img/sad_on.png"];
  Diary diary = Diary(id: 1, mood: 0, title: "오늘의 하루..", done: false, memo: "오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요"
      "오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요"
      " 오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요"
      " 오늘은 이런저런 많은 일이 있었다."
      " 정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다. 정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다. 정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요오늘은 이런저런 많은 일이 있었다."
      "정말 힘은 들었지만 재미는 아주 있었어요", date: 20210707, background: "https://i.pinimg.com/originals/2d/46/b5/2d46b541349351f20ce5f10f0b5e320e.jpg");
  int _selectedIndex = 0;
  final calenderController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        key: Key("bottomNavigation"),
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.today_sharp, size: 22.0), label: "오늘"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined, size: 20.0), label: "기록"),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, size: 20.0,),
            label: "더보기",
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
      ),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        onPressed: () async {
          final _diary = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiaryWritePage(diary: diary)));
          setState(() {

          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ) : Container(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPage(){
    if(_selectedIndex == 0){
      return Stack(children: [
        Positioned.fill(
          child: Image.network("https://i.pinimg.com/originals/2d/46/b5/2d46b541349351f20ce5f10f0b5e320e.jpg", fit: BoxFit.cover,),
        ),
        Positioned.fill(child: ListView.builder(
          itemBuilder: (ctx, idx){
            if(idx == 0){
              final d = Utils.stringToDateTime(diary.date.toString());
              return Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${d.year}.${d.month}.${d.day}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(child: Image.asset("${emoji[diary.mood]}", fit: BoxFit.cover,),
                      height: 50, width: 50,)
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              );
            }
            else if(idx == 1){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16)

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(diary.title, style: TextStyle(fontSize: 18)),
                    Container(height: 12),
                    Text(diary.memo, style: TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }
            else if(idx == 2){
            }
            return Container();
          },
          itemCount: 4,
        )),
      ]);
    }
    else if(_selectedIndex == 1){
      return ListView.builder(
        itemBuilder: (ctx, idx){
          if(idx == 0){
            return Container(
              child: TableCalendar(
                locale: "ko-KR",
                calendarController: calenderController,
                onDaySelected: (date, event, holidays){
                  setState(() {
                    diary.date = Utils.getFormatTime(date);
                    diary.title = "참 좋은 하루";
                  });

                },
              ),
            );
          }else if(idx == 1){
            final d = Utils.stringToDateTime(diary.date.toString());
            return Container(child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${d.year}.${d.month}.${d.day}", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(child: Image.asset("${emoji[diary.mood]}", fit: BoxFit.cover,),
                        height: 50, width: 50,)
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16)

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(diary.title, style: TextStyle(fontSize: 18)),
                      Container(height: 12),
                      Text(diary.memo, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12, width: 7))
              ),
            );
          }
          else{

          }
          return Container();
        },
        itemCount: 5,
      );
    }
    return Container();
  }
}

class Diary {
  int id;
  int date;
  bool done;
  int mood;
  String title;
  String memo;
  String background;

  Diary({this.id, this.date, this.mood, this.memo, this.background, this.title, this.done});
}

class DiaryWritePage extends StatefulWidget {
  final Diary diary;
  DiaryWritePage({Key key, this.diary}) : super(key: key);

  @override
  _DiaryWritePageState createState() => _DiaryWritePageState();
}

class _DiaryWritePageState extends State<DiaryWritePage> {
  Diary get diary => widget.diary;
  // Diary diary  = Diary(id: 1, title: "asdfasdf", memo: "", done: false);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    _titleController.text = diary.title ?? "";
    _memoController.text = diary.memo ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        actions: [
          TextButton(
            child: Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).pop(diary);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx){
          if(idx == 0){
            return Container(
              child: Align(child: AspectRatio(child: Image.network("https://i.pinimg.com/originals/2d/46/b5/2d46b541349351f20ce5f10f0b5e320e.jpg", fit: BoxFit.cover,),
              aspectRatio: 1,),
                alignment: Alignment.centerLeft,
              ),
              height: 70,
              width: 70,
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            );
          }
          else if(idx == 1){
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(child: Container(
                    width: 50, height: 50,
                    child: Image.asset(diary.mood == 0 ? "img/happy_on.png" : "img/happy_off.png"),
                  ),
                    onTap: (){
                    setState(() {
                      diary.mood = 0;
                    });
                    },
                  ),
                  InkWell(child: Container(
                    width: 50, height: 50,
                    child: Image.asset(diary.mood == 1 ? "img/soso_on.png" : "img/soso_off.png"),
                  ),
                    onTap: (){
                      setState(() {
                        diary.mood = 1;
                      });
                    },
                  ),
                  InkWell(child: Container(
                    width: 50, height: 50,
                    child: Image.asset(diary.mood == 2 ? "img/sad_on.png" : "img/sad_off.png"),
                  ),
                    onTap: (){
                      setState(() {
                        diary.mood = 2;
                      });
                    },
                  ),
                ],
              ),
            );
          }
          else if(idx == 2){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text("제목", style: TextStyle(fontSize: 22, color: Colors.black)),
            );
          }
          else if(idx == 3) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onTap: (){
                },
                controller: _titleController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v){
                  diary.title = v;
                },
                onSubmitted: (v){

                },
              ),
            );
          }
          else if(idx == 4){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text("내용", style: TextStyle(fontSize: 22, color: Colors.black)),
            );
          }
          else if(idx == 5) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: TextField(
                controller: _memoController,
                maxLines: 10,
                minLines: 10,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
                onChanged: (v){
                  diary.memo = v;
                },
                onSubmitted: (v){},
              ),
            );
          }

          return Container();
        },
        itemCount: 7,
      ),
    );
  }
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