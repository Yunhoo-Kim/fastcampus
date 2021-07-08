import 'package:fastcampus/api.dart';
import 'package:flutter/material.dart';


class MisePage extends StatefulWidget {
  MisePage({Key key}) : super(key: key);

  @override
  _MisePageState createState() => _MisePageState();
}

class _MisePageState extends State<MisePage> {
  // List<Diary> diary = [
  //   Diary(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기"),
  //   Diary(id: 2, title: "헬스 2시간", done: false, memo: "어깨운동"),
  // ];
  List<String> emoji = ["img/mise/ico-happy.png", "img/mise/ico-sceptic.png", "img/mise/ico-sad.png", "img/mise/ico-angry.png"];
  List<String> text = ["오늘은 날씨가 좋아요!\n밖으로 산책을 나가보는건 어떨까요?", "미세먼지가 조금 있어요.\n마스크를 착용하세요", "미세먼지가 너무 많아요.\n외출을 자제하세요"];
  List<Color> colors = [Color(0xFF0077c2), Color(0xFF009ba9), Color(0xFFfe6300), Color(0xFFd80019)];
  List<String> level = ["좋음", "보통", "나쁨", "매우나쁨"];
  List<MiseData> histories = [];
  int _selectedIndex = 0;
  String location = "구로구";

  void loadMise() async {
    final api = MiseApi();
    histories = await api.getAllHistories(location);
    histories.removeWhere((m) => m.pm10 == 0);
    setState(() {

    });
  }

  @override
  void initState() {
    loadMise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(histories.isEmpty){
      return Container();
    }
    final history = histories.firstWhere((m) => m.pm10 > 1);

    _selectedIndex = getLevel(history);
    _selectedIndex = 2;

    return Scaffold(
      body: histories.isEmpty ? Container() : Container(
        color: colors[_selectedIndex],
        child: Column(
          children: [
            Container(height: 100),
            Text("현재 위치", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),),
            Container(height: 8),
            Text("[$location]", style: TextStyle(fontSize: 18, color: Colors.white),),
            Container(height: 60),
            InkWell(child: Container(
                height: 250,
                width: 250,
                child: Image.asset(emoji[_selectedIndex], fit: BoxFit.contain,)),
                onTap: () async {
                }
            ),
            Container(height: 60),
            Text("${level[_selectedIndex]}", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),),
            Container(height: 12),
            Text("통합 대기환경 지수 ${history.khai}", style: TextStyle(fontSize: 18, color: Colors.white),),
            Expanded(
              child: Container(child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: histories.length,
                itemBuilder: (ctx, _idx){
                  final mise = histories[_idx];
                  int level = getLevel(mise);
                  return Container(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${mise.dataTime.split(" ")[0]}", style: TextStyle(color: Colors.white, fontSize: 10),),
                      Text("${mise.dataTime.split(" ")[1]}", style: TextStyle(color: Colors.white, fontSize: 10),),
                      Container(height: 8,),
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(emoji[level]),
                      ),
                      Container(height: 8,),
                      Text("${mise.pm10}ug/m2", style: TextStyle(color: Colors.white),)
                    ],
                  ),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  );
                },
              ),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _diary = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LocationPage(location: "",)));
          setState(() {
            if(_diary != null){
              location = _diary;
              loadMise();
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.location_on),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  int getLevel(MiseData mise){
    if(mise.pm10 > 150){
      return 3;
    }else if(mise.pm10 > 80){
      return 2;
    }else if(mise.pm10 > 30){
      return 1;
    }else {
      return 0;
    }
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
            ListTile(title: Text("대정읍"), onTap: (){
              Navigator.of(context).pop("대정읍");
            },),
          ],
        ));
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

class MiseData {
  String dataTime;
  int pm10;
  int pm25;
  double so;
  double co;
  double no;
  double o3;
  int khai;

  MiseData({this.pm10, this.pm25, this.so, this.co, this.no, this.o3, this.dataTime, this.khai});

  factory MiseData.fromJson(Map<String, dynamic> data){
    print(data);
    return MiseData(
      pm10: int.tryParse(data["pm10Value"] ?? "") ?? 0,
      pm25: int.tryParse(data["pm25Value"] ?? "") ?? 0,
      so: double.tryParse(data["so2Value"] ?? "") ?? 0,
      co: double.tryParse(data["coValue"] ?? "") ?? 0,
      no: double.tryParse(data["no2Value"] ?? "") ?? 0,
      o3: double.tryParse(data["o3Value"] ?? "") ?? 0,
      khai: int.tryParse(data["khaiGrade"] ?? "") ?? 0,
      dataTime: data["dataTime"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "pm10": this.pm10,
      "pm25": this.pm25,
      "so": this.so,
      "co": this.co,
      "no": this.no,
      "o3": this.o3,
      "khai": this.khai,
      "dataTime": this.dataTime
    };
  }
}