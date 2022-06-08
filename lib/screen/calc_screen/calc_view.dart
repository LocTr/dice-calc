// ignore_for_file: prefer_const_constructors

import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calc_button_grid.dart';

class CalcView extends StatelessWidget {
  const CalcView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild view');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.all(4),
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<CalcBloc, CalcState>(
                        builder: (context, state) {
                          return Flexible(
                            child: Text(
                              context.watch<CalcBloc>().state.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<CalcBloc, CalcState>(
                        builder: (context, state) {
                          return Flexible(
                            child: Text(
                              context.watch<CalcBloc>().state.resultScreen,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                CalcButtonGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
