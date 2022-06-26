import 'dart:io';

import 'package:dice_calc/screen/calc_screen/calc_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError;
    if (kReleaseMode) exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('historyBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   // textButtonTheme: TextButtonThemeData(
      //   //   style: ButtonStyle(
      //   //     backgroundColor: MaterialStateProperty.all(Colors.black87),
      //   //     foregroundColor: MaterialStateProperty.all(Colors.white70),
      //   //   ),
      //   // ),
      // ),
      theme: ThemeData(),
      home: const CalcPage(),
    );
  }
}
