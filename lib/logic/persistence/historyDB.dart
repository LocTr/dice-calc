import 'package:hive_flutter/hive_flutter.dart';

class HistoryDB {
  static void put({required String equator, required String result}) {
    var box = Hive.box('historyBox');
    if (equator != result) box.add([equator, result]);
  }

  static Map readAll() {
    var box = Hive.box('historyBox');
    return box.toMap();
  }

  static void clear() {
    var box = Hive.box('historyBox');
    box.clear();
  }
}
