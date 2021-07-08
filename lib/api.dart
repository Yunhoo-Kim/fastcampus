import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:fastcampus/mise.dart';
import 'package:fastcampus/weather.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:wepoong/data/advertisement.dart';
// import 'package:wepoong/data/database.dart';
// import 'package:wepoong/data/preference.dart';
// import 'package:wepoong/data/response.dart';
// import 'package:wepoong/data/user.dart';
// import 'package:wepoong/data/wepoong.dart';
// import 'package:wepoong/view/utils.dart';
//
class MiseApi {
// final BASE_URL = "http://192.168.0.5:8000";
//  final BASE_URL = "http://10.1.16.215:8000";
  final BASE_URL = "http://apis.data.go.kr";


  final IMAGE_BASE_URL = "https://image.yunhookim.com";
//  final IMAGE_BASE_URL = "http://127.0.0.1:3000";

// final pref = Preference();
// final dbHelper = DatabaseHelper.instance;
  final String key =
      // "LZDQOJ1Kas/bmEHx6RAwIxYkzp4Nketgm14YQWFqnRpW6AZ1Zwo1e/e5xwd2/kGNbuf4DpjN8FgSbsJuSc5aYQ==";
  "LZDQOJ1Kas%2FbmEHx6RAwIxYkzp4Nketgm14YQWFqnRpW6AZ1Zwo1e%2Fe5xwd2%2FkGNbuf4DpjN8FgSbsJuSc5aYQ%3D%3D";

  final Map<String, String> headers = {
    'Content-type': 'application/json;charset=utf-8',
    'Accept': 'application/json',
  };

  Future<List<MiseData>> getAllHistories(String name) async {
    // String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=LZDQOJ1Kas%2FbmEHx6RAwIxYkzp4Nketgm14YQWFqnRpW6AZ1Zwo1e%2Fe5xwd2%2FkGNbuf4DpjN8FgSbsJuSc5aYQ%3D%3D&returnType=xml&numOfRows=100&pageNo=1&stationName=%EC%A2%85%EB%A1%9C%EA%B5%AC&dataTerm=DAILY&ver=1.0";
    String url = "$BASE_URL/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
        "?serviceKey=$key&returnType=json&"
        "numOfRows=100&pageNo=1&stationName=${Uri.encodeQueryComponent(name)}&"
        "dataTerm=DAILY&ver=1.0";
    final response = await http.get(
        url, headers: headers);
    print(url);
    List<MiseData> histories = [];
    print(utf8.decode(response.bodyBytes));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      var res = json.decode(body) as Map<String, dynamic>;
      for (final _res in res["response"]["body"]["items"]) {
        // print(_res);
        final m = MiseData.fromJson(_res as Map<String, dynamic>);
        histories.add(m);
        print(m.toJson());
        // var ad = WepoongHistory.fromServer(_res as Map<String, dynamic>);
        // dbHelper.insertWepoongHistory(ad);
        // histories.add(ad);
      }

      // pref.setLastBackupDate(WepoongUtils.getFormatTime(DateTime.now()));
      return histories;
    } else {
      throw Exception("error");
    }
  }

  Future<List<Weather>> getWeather(int x, int y, int date, int base_time) async{
    String url = "$BASE_URL/1360000/VilageFcstInfoService_2.0/getVilageFcst?"
        "serviceKey=$key&pageNo=1&numOfRows=100&dataType=json&base_date=$date&base_time=${WeatherUtils.makeFourDigit(base_time)}&"
        "ny=$y&nx=$x";
    // print(url);
    final response = await http.get(url);
    List<Weather> fcst = [];
    if(response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);

      print(body);
      var res = json.decode(body) as Map<String, dynamic>;

      List<dynamic> _data = [];
      _data = res["response"]["body"]["items"]["item"] as List<dynamic>;
      final data = groupBy(_data, (obj) => "${obj["fcstTime"]}").entries.toList();

      for(final _res in data){
        final _data = {
          "fcstTime": _res.key,
          "fcstDate": _res.value.first["fcstDate"],
        };
        for(final _r in _res.value){
          _data[_r["category"]] = _r["fcstValue"];
        }

        final w = Weather.fromJson(_data);
        // print(w.toJson());
        fcst.add(w);
      }
      return fcst;
    }else{
      return [];
    }
  }
}
