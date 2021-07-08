import 'package:fastcampus/api.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class WeatherPage extends StatefulWidget {
  WeatherPage({Key key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // List<Diary> diary = [
  //   Diary(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기"),
  //   Diary(id: 2, title: "헬스 2시간", done: false, memo: "어깨운동"),
  // ];
  List<String> emoji = ["img/weather/ico-weathe-02-r.png", "img/weather/ico-weather-01.png",
    "img/weather/ico-weather_5.png", "img/weather/ico-weather-04.png"];
  List<String> cloth = ["img/padding.png", "img/coat.png", "img/raincoat.png", "img/cloth.png", "img/tshirt.png"];
  List<String> text = ["오늘은 날이 맑아요", "구름이 조금 있어요", "구름이 잔뜩 꼈네요", "비 조심하세요"];
  List<String> temp = ["-10℃", "0℃", "5℃", "20℃"];
  List<List<String>> clothes = [
    ["img/weather/ico-jumper.png","img/weather/ico-jumper.png","img/weather/ico-jumper.png"],
    ["img/weather/ico-pants.png","img/weather/ico-jumper.png","img/weather/ico-shirts.png"],
    ["img/weather/ico-jumper.png","img/weather/ico-long-sleeve.png","img/weather/ico-umbrella.png"],
  ];
  List<Color> colors = [Color(0xFFf78144), Color(0xFF1d9fea), Color(0xFF523de4), Color(0xFF587d9a)];
  int _selectedIndex = 0;
  int clothIndex = 0;
  String location = "구로구";
  Weather weather;
  DateTime now = DateTime.now();

  // final hourForm = DateFormat().

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    if(weathers.isNotEmpty){
      if(weather == null){
        weather = weathers.first;
      }
    }
    if(weather != null) {
      if (weather.tmp > 26) {
        clothIndex = 2;
      } else if (weather.tmp > 7) {
        clothIndex = 1;
      } else {
        clothIndex = 0;
      }
    }


    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: colors[_selectedIndex],
        child: weathers.isEmpty ? Container() : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 50),
            Text("$location", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,),
            Container(height: 30),
            Container(child: Image.asset(emoji[_selectedIndex], fit: BoxFit.contain,),
                width: 100,
                height: 100,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 30),
            ),
            Container(height: 30),
            Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(text:TextSpan(text: "${weather.tmp}", style: TextStyle(fontSize: 80, color: Colors.white),
                children: [
                  TextSpan(text: "°C", style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ))
                ]),

                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${now.month}월 ${now.day}일", style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text("${text[_selectedIndex]}", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                )
              ],
            ), margin: EdgeInsets.symmetric(horizontal: 0),),
            Container(height: 30),
            Text("오늘 어울리는 복장을 추천드려요", style: TextStyle(fontSize: 16, color: Colors.white)),
            Container(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(clothes[clothIndex].length, (idx){
                return Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(clothes[clothIndex][idx], fit: BoxFit.contain),
                );
              }),
            ),
            Container(height: 30),
            Expanded(child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 0),
                scrollDirection: Axis.horizontal,
                children: List.generate(weathers.length, (idx){
                  final w = weathers[idx];
                  int _idx = 0;
                  if(w.sky > 8){
                    _idx = 3;
                  }else if(w.sky > 5){
                    _idx = 2;
                  }else if(w.sky > 3){
                    _idx = 1;
                  }else{
                    _idx = 0;
                  }

                  DateTime now = DateTime.now();

                  return Container(child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${w.tmp}°C", style: TextStyle(color: Colors.white),),
                      Text("${w.pop}%", style: TextStyle(color: Colors.white),),
                      Container(child: Image.asset(emoji[_idx]), width: 70, height: 70,),
                      Text("${w.time}", style: TextStyle(color: Colors.white),)
                    ],
                  ), margin: EdgeInsets.symmetric(horizontal: 8),);
                }
                  ,
                ))),
            Container(height: 60,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final _diary = await Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => LocationPage(location: "",)));
          getWeather();
          setState(() {
            // if(_diary != null){
            //   location = _diary;
            _selectedIndex++;
            _selectedIndex = _selectedIndex % cloth.length;
            // }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Weather> weathers = [];

  void getWeather() async {
    DateTime now = DateTime.now();
    int time = 0200;
    int hour = WeatherUtils.getHour(now);

    if(hour >= 2310){
      time = 2300;
    }else if(hour >= 2010){
      time = 2000;
    }else if(hour >= 1710){
      time = 1700;
    }else if(hour >= 1410){
      time = 1400;
    }else if(hour >= 1110){
      time = 1100;
    }else if(hour >= 810){
      time = 800;
    }else if(hour >= 510){
      time = 500;
    }else if(hour >= 210){
      time = 200;
    }
    final api = MiseApi();
    // WeatherUtils.l
    final data = WeatherUtils.latLngToXY(37.5435600, 126.9510950);
    print(data);

    weathers = await api.getWeather(data["nx"], data["ny"], WeatherUtils.getFormatTime(now), time);

    for(final w in weathers){
      if(w.time == int.parse("${now.hour}00")){
        weather = w;
        break;
      }
    }
    if(weather.sky > 8){
      _selectedIndex = 3;
    }else if(weather.sky > 5){
      _selectedIndex = 2;
    }else if(weather.sky > 3){
      _selectedIndex = 1;
    }else{
      _selectedIndex = 0;
    }
    print(weather.toJson());

    setState(() {});
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
}

class Weather {
  String date;
  int time;
  int pop;
  int pty;
  String pcp;
  int sky;
  double wsd;
  int tmp;
  int reh;

  Weather({this.date, this.time, this.pop, this.pty, this.pcp, this.sky, this.wsd, this.tmp, this.reh});

  factory Weather.fromJson(Map<String, dynamic> data){
    return Weather(
        date: data["fcstDate"],
        time: int.tryParse(data["fcstTime"] ?? "") ?? 0,
        pop: int.tryParse(data["POP"] ?? "") ?? 0,
        pty: int.tryParse(data["PTY"] ?? "") ?? 0,
        pcp: data["PCP"] ?? "",
        sky: int.tryParse(data["SKY"] ?? "") ?? 0,
        wsd: double.tryParse(data["WSD"] ?? "") ?? 0.0,
        tmp: int.tryParse(data["TMP"] ?? "") ?? 0,
        reh: int.tryParse(data["REH"] ?? "") ?? 0
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "date": date,
      "time": time,
      "pop": pop,
      "pty": pty,
      "pcp": pcp,
      "sky": sky,
      "wsd": wsd,
      "tmp": tmp,
      "reh": reh,
    };
  }
}

class WeatherUtils {
  static String makeTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }
  static String makeFourDigit(int number) {
    return number.toString().padLeft(4, '0');
  }
  static int getFormatTime(DateTime date) {
    return int.parse(
        "${date.year}${WeatherUtils.makeTwoDigit(date.month)}${WeatherUtils.makeTwoDigit(date.day)}");
  }

  static int getHour(DateTime date) {
    return int.parse("${WeatherUtils.makeTwoDigit(date.hour)}${WeatherUtils.makeTwoDigit(date.minute)}");
  }

  static DateTime stringToDateTime(String date) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(4, 6));
    int day = int.parse(date.substring(6, 8));

    return DateTime(year, month, day);
  }
  static Map<String, int> latLngToXY(double v1, double v2) {
    var RE = 6371.00877; // 지구 반경(km)
    var GRID = 5.0; // 격자 간격(km)
    var SLAT1 = 30.0; // 투영 위도1(degree)
    var SLAT2 = 60.0; // 투영 위도2(degree)
    var OLON = 126.0; // 기준점 경도(degree)
    var OLAT = 38.0; // 기준점 위도(degree)
    var XO = 43; // 기준점 X좌표(GRID)
    var YO = 136; // 기1준점 Y좌표(GRID)

    var DEGRAD = math.pi / 180.0;
    var RADDEG = 180.0 / math.pi;

    var re = RE / GRID;
    var slat1 = SLAT1 * DEGRAD;
    var slat2 = SLAT2 * DEGRAD;
    var olon = OLON * DEGRAD;
    var olat = OLAT * DEGRAD;

    var sn = math.tan(math.pi * 0.25 + slat2 * 0.5) /
        math.tan(math.pi * 0.25 + slat1 * 0.5);
    sn = math.log(math.cos(slat1) / math.cos(slat2)) / math.log(sn);
    var sf = math.tan(math.pi * 0.25 + slat1 * 0.5);
    sf = math.pow(sf, sn) * math.cos(slat1) / sn;
    var ro = math.tan(math.pi * 0.25 + olat * 0.5);
    ro = re * sf / math.pow(ro, sn);
    Map<String, int> rs = {};
    // rs['lat'] = v1;
    // rs['lng'] = v2;
    var ra = math.tan(math.pi * 0.25 + (v1) * DEGRAD * 0.5);
    ra = re * sf / math.pow(ra, sn);
    var theta = v2 * DEGRAD - olon;
    if (theta > math.pi) theta -= 2.0 * math.pi;
    if (theta < -math.pi) theta += 2.0 * math.pi;
    theta *= sn;
    rs['nx'] = (ra * math.sin(theta) + XO + 0.5).floor();
    rs['ny'] = (ro - ra * math.cos(theta) + YO + 0.5).floor();
    return rs;
  }
}