import 'package:hive_flutter/hive_flutter.dart';

class HistoryDB {
  static void put({required String equator, required String result}) {
    var box = Hive.box('settingBox');
    box.add([equator, result]);
  }

  static Map readAll() {
    var box = Hive.box('historyBox');
    return box.toMap();
  }
}
