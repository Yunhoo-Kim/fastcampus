// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fastcampus/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Future<Map<String, dynamic>> getUserSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String days = pref.getString("days") ?? "";
    int startTime = pref.getInt("startTime") ?? 20;
    int startTimeMin = pref.getInt("startTimeMin") ?? 0;
    int startDate = pref.getInt("startDate");
    double height = pref.getDouble("height") ?? 165.0;
    double weight = pref.getDouble("weight") ?? 0.0;
    double water = pref.getDouble("waterAmount") ?? 2.0;
    bool waterAuto = pref.getBool("waterAuto") ?? false; // 건강앱 자동 연동
    bool isFirstOpen = pref.getBool("isFirstOpen") ?? true;
    bool isFirstOpenAfterDayScheduleUpdate =
        pref.getBool("isFirstOpenAfterDayScheduleUpdate") ?? true;
    bool removeAds = pref.getBool("removeAds") ?? false;
    bool engage = pref.getBool("engage") ?? true;
    String selfEndTime = pref.getString("selfEndTime");
    String bgPath = pref.getString("bgPath") ?? "";
    String email = pref.getString("email") ?? "";
    String password = pref.getString("password") ?? "";
    String startNotificationTitle = pref.getString("startNotificationTitle") ?? "";
    String startNotification = pref.getString("startNotification") ?? "";
    String endNotificationTitle = pref.getString("endNotificationTitle") ?? "";
    String endNotification = pref.getString("endNotification") ?? "";
    bool bio = pref.getBool("bio") ?? false;
    bool showWeight = pref.getBool("showWeight") ?? false;
    bool autoWeight = pref.getBool("autoWeight") ?? false;
    bool saveServer = pref.getBool("saveServer") ?? false;
    int autoWeightDate = pref.getInt("autoWeightDate") ?? 0;
    int calendarMode = pref.getInt("calendarMode") ?? 0;
    int calendarDaysMode = pref.getInt("calendarDaysMode") ?? 0;
    int mainMode = pref.getInt("mainMode") ?? 2;
    int statusBar = pref.getInt("statusBar") ?? 0;
    String lastWeight = pref.getString("lastWeight") ?? "";

    if (startDate == null) {
      var now = DateTime.now();
//      now = now.subtract(Duration(days: 2));
      startDate = WeatherUtils.getFormatTime(now);
      pref.setInt("startDate", startDate);
    }
    pref.setBool("isFirstOpen", false);
    pref.setBool("isFirstOpenAfterDayScheduleUpdate", false);

    int duration = pref.getInt("duration") ?? 16;
    int fastType = pref.getInt("fastType") ?? 0;
    int noti = pref.getInt("noti") ?? 1;
    int daysType = pref.getInt("daysType") ?? 0;
    bool timeMode = pref.getBool("timeMode") ?? false;
    bool weightCalendarExpanded = pref.getBool("weightExpanded") ?? false;

    return {
      "days": days,
      "daysType": daysType,
      "startTime": startTime,
      "startTimeMin": startTimeMin,
      "duration": duration,
      "fastType": fastType,
      "startDate": startDate,
      "noti": noti,
      "engage": engage,
      "isFirstOpen": isFirstOpen,
      "isFirstOpenAfterDayScheduleUpdate": isFirstOpenAfterDayScheduleUpdate,
//      "isFirstOpen": true,
      "removeAds": removeAds,
      // "removeAds": true,
      "selfEndTime": selfEndTime,
      "statusBar": statusBar,
      "timeMode": timeMode,
      "mainMode": mainMode,
      "bgPath": bgPath,
      "email": email,
      "height": height,
      "weight": weight,
      "lastWeight": lastWeight,
      "password": password,
      "bio": bio,
      "weightCalendarExpanded": weightCalendarExpanded,
      "startNotificationTitle": startNotificationTitle,
      "startNotification": startNotification,
      "endNotificationTitle": endNotificationTitle,
      "endNotification": endNotification,
      "showWeight": showWeight,
      "autoWeight": autoWeight,
      "saveServer": saveServer,
      "autoWeightDate": autoWeightDate,
      "calendarMode": calendarMode,
      "calendarDaysMode": calendarDaysMode,
      "waterAmount": water,
      "waterAuto": waterAuto
    };
  }

  Future<Map<String, int>> getFastDays() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int wholeFastDays = pref.getInt("wholeFastDays") ?? 0;
    int wholeFastHours = pref.getInt("wholeFastHours") ?? 0;

    return {"wholeFastDays": wholeFastDays, "wholeFastHours": wholeFastHours};
  }

  Future<bool> isDarkMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool darkMode = pref.getBool("darMode") ?? false;

    return darkMode;
  }

  Future<bool> isFirstOpen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool removeAds = pref.getBool("isFirstOpen") ?? true;

    return removeAds;
  }

  Future<bool> isPremium() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool removeAds = pref.getBool("removeAds") ?? false;

    return removeAds;
    // return true;
  }

  Future<bool> isLocked() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String pwd = pref.getString("password") ?? "";

    return pwd.isNotEmpty;
  }

  Future<void> setClickPurchase(bool clicked) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("clickPurchase", clicked);
  }

  Future<bool> clickPurchase() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool darkMode = pref.getBool("clickPurchase") ?? false;

    return darkMode;
  }

  Future<void> setDarkMode(bool darkMode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("darMode", darkMode);
  }

  Future<void> setRemoveAds(bool removeAds) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("removeAds", removeAds);
  }

  Future<void> setSelfEndTime(String selfEndTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("selfEndTime", selfEndTime);
  }

  Future<void> setLastEndTime(String lastEndTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("lastEndTime", lastEndTime);
  }

  Future<void> setPassword(String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("password", password);
  }

  Future<void> setBio(bool bio) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("bio", bio);
  }

  Future<void> setShowWeight(bool bio) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("showWeight", bio);
  }

  Future<void> setSaveServer(bool bio) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("saveServer", bio);
  }

  Future<bool> getSaveServer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("saveServer") ?? false;
  }

  Future<void> setAutoWeight(bool bio) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("autoWeight", bio);
  }

  Future<void> setAutoWeightDate(int date) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("autoWeightDate", date);
  }

  Future<void> setCalendarMode(int startTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("calendarMode", startTime);
  }
  Future<void> setCalendarDaysMode(int startTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("calendarDaysMode", startTime);
  }

  Future<void> setStartTime(int startTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("startTime", startTime);
  }

  Future<void> setStartDate(int startDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("startDate", startDate);
  }

  Future<int> getStartDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("startDate");
  }

  Future<int> getBackupDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int backupDate = pref.getInt("backupDate") ?? -1;
    // int backupDate = 20200922;
    if(backupDate == -1){
      final now = DateTime.now();
      backupDate = WeatherUtils.getFormatTime(now);
      pref.setInt("backupDate", backupDate);
    }
    return backupDate;
  }

  Future<void> setBackupDate(int backupDate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("backupDate", backupDate);
  }

  Future<void> setStartTimeMin(int startTimeMin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("startTimeMin", startTimeMin);
  }

  Future<void> setDuration(int duration) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("duration", duration);
  }

  Future<void> setFastType(int fastType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("fastType", fastType);
  }

  Future<void> setDays(String days) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("days", days);
  }

  Future<void> setDaysType(int fastType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("daysType", fastType);
  }

  Future<void> setNotification(int noti) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("noti", noti);
  }

  Future<void> setEngagedNoti(bool noti) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("engage", noti);
  }

  Future<void> setTimeMode(bool t) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("timeMode", t);
  }

  Future<void> setWeightCalendarExpanded(bool t) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("weightCalendarExpanded", t);
  }

  Future<bool> getTimeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("timeMode") ?? false;
  }

  Future<String> getPopUpTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("popup") ?? "";
  }

  Future<void> setPopUpTime(String popup) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString("popup", popup);
  }

  Future<void> setWholeFastDays(int wholeFastDays) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("wholeFastDays", wholeFastDays);
  }

  Future<int> getWholeFastDays() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("wholeFastDays") ?? 0;
  }

  Future<void> setWholeFastHours(int wholeFastHours) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("wholeFastHours", wholeFastHours);
  }

  Future<int> getWholeFastHours() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("wholeFastHours") ?? 0;
  }

  Future<void> setBGPath(String bgPath) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("bgPath", bgPath);
  }

  Future<String> getBGPath() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("bgPath") ?? "";
  }

  Future<void> setEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", email);
  }

  Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("email") ?? "";
  }

  Future<void> setStatusBar(int status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("statusBar", status);
  }

  Future<void> setDaysSchedule(Map<String, int> days) async {
    List<int> duration = [];
    List<int> startTime = [];
    List<int> startTimeMin = [];

    for(int i = 0; i < 7; i++){
      duration.add(days["duration_$i"]);
      startTime.add(days["startTime_$i"]);
      startTimeMin.add(days["startTimeMin_$i"]);
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("daysDuration", duration.join(","));
    await pref.setString("daysStartTime", startTime.join(","));
    await pref.setString("daysStartTimeMin", startTimeMin.join(","));
  }

  Future<Map<String, int>> getDaysSchedule() async {

    Map<String, int> daysScheduleDetail = {};

    SharedPreferences pref = await SharedPreferences.getInstance();
    final daysDuration = pref.getString("daysDuration") ?? "";
    final daysStartTime = pref.getString("daysStartTime") ?? "";
    final daysStartTimeMin = pref.getString("daysStartTimeMin") ?? "";

    List<int> durations = [];
    List<int> startTimes = [];
    List<int> startTimeMinutes = [];

    if(daysDuration.isNotEmpty && daysStartTime.isNotEmpty && daysStartTimeMin.isNotEmpty){
      durations = daysDuration.split(",").map((s) => int.parse(s)).toList();
      startTimes = daysStartTime.split(",").map((s) => int.parse(s)).toList();
      startTimeMinutes = daysStartTimeMin.split(",").map((s) => int.parse(s)).toList();
    }

    if(durations.length == 7 && startTimes.length == 7 && startTimeMinutes.length == 7) {
      for (int i = 0; i < 7; i++) {
        daysScheduleDetail.addAll({"duration_$i": durations[i]});
        daysScheduleDetail.addAll({"startTime_$i": startTimes[i]});
        daysScheduleDetail.addAll({"startTimeMin_$i": startTimeMinutes[i]});
      }
    }

    return daysScheduleDetail;

  }

  Future<String> getDaysDuration() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final daysDuration = pref.getString("daysDuration") ?? "";
    final daysStartTime = pref.getString("daysStartTime") ?? "";
    final daysStartTimeMin = pref.getString("daysStartTimeMin") ?? "";
    return daysDuration;
  }

  Future<String> getDaysStartTime() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final daysStartTime = pref.getString("daysStartTime") ?? "";
    return daysStartTime;
  }

  Future<String> getDaysStartTimeMin() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    final daysStartTimeMin = pref.getString("daysStartTimeMin") ?? "";
    return daysStartTimeMin;
  }

  Future<void> setHeight(double height) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("height", height);
  }

  Future<void> setWeight(double weight) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("weight", weight);
  }

  Future<void> setLastWeight(String weight) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("lastWeight", weight);
  }

  Future<int> getMainMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("mainMode") ?? 2;
  }

  Future<void> setMainMode(int t) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("mainMode", t);
  }

  Future<void> setStartNotificationTitle(String c) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("startNotificationTitle", c);
  }

  Future<void> setStartNotificationContext(String c) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("startNotification", c);
  }

  Future<void> setEndNotificationTitle(String c) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("endNotificationTitle", c);
  }
  Future<void> setEndNotificationContext(String c) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("endNotification", c);
  }

  Future<String> getStartNotificationTitle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("startNotificationTitle") ?? "";
  }

  Future<String> getStartNotificationContext() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("startNotification") ?? "";
  }

  Future<String> getEndNotificationTitle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("endNotificationTitle") ?? "";
  }
  Future<String> getEndNotificationContext() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("endNotification") ?? "";
  }

  Future<void> setWaterAmount(double water) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("waterAmount", water);
  }

  Future<void> setWaterAuto(bool water) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("waterAuto", water);
  }

  Future<double> getWaterAmount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getDouble("waterAmount") ?? 2.0;
  }

  Future<void> setAndroidWidgetColor(int color) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("aWColor", color);
  }

  Future<Map<String, dynamic>> getAndroidWidgetSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int color = pref.getInt("aWColor") ?? 0xfffff;
    return {
      "color": color
    };
  }

  Future<void> resetPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var now = DateTime.now();
    var startDate = WeatherUtils.getFormatTime(now);
    var removeAds = await isPremium();

    await pref.clear();
    pref.setInt("startDate", startDate);
    pref.setInt("wholeFastHours", 0);
    pref.setInt("wholeFastDays", 0);
    pref.setBool("removeAds", removeAds);
    pref.setString("selfEndTime", null);
  }
}
