import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/screen/calc_screen/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.black87),
        //     foregroundColor: MaterialStateProperty.all(Colors.white70),
        //   ),
        // ),
      ),
      home: BlocProvider(
        create: (context) => CalcBloc(),
        child: const CalcScreen(),
      ),
    );
  }
}
