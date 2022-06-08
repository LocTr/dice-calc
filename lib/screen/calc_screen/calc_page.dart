import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/screen/calc_screen/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalcBloc(),
      child: const CalcView(),
    );
  }
}
