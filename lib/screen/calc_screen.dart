import 'package:dice_calc/logic/bloc/calc_bloc.dart';
import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcScreen extends StatelessWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Flexible(
                        child: Text(
                          context.watch<CalcBloc>().state.equationScreen,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        // IDEAS: chip with condition appear when condition is typed
                        Expanded(
                            child: CalcButton(
                          childText: 'drop',
                          onPressed: () {
                            // context
                            //     .read<CalcBloc>()
                            //     .add(const CharacterAdded(character: 'd10'));
                          },
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'keep',
                          onPressed: () {},
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'explode',
                          onPressed: () {},
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'reroll',
                          onPressed: () {},
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '7',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '8',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '9',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'dN',
                          onPressed: () {},
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '4',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '5',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '6',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '+',
                          onPressed: () {},
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '1',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '2',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '3',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '-',
                          onPressed: () {},
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '0',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '(',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: ')',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '=',
                          onPressed: () {},
                        )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
