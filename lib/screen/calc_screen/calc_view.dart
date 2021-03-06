// ignore_for_file: prefer_const_constructors

import 'package:dice_calc/bloc/calc_bloc/calc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calc_button_grid.dart';

class CalcView extends StatelessWidget {
  const CalcView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView(
                    reverse: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      BlocBuilder<CalcBloc, CalcState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.right,
                              maxLines: 10,
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
