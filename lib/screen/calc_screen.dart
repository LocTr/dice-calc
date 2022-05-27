// ignore_for_file: prefer_const_constructors

import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
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
                          context.watch<CalcBloc>().state.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          context.watch<CalcBloc>().state.resultScreen,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // TODO: beautify this row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              context.read<CalcBloc>().add(ElementRemoved());
                            },
                            icon: Icon(Icons.backspace_outlined)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        // IDEAS: chip with condition appear when condition is typed
                        Expanded(
                            child: CalcButton(
                          childText: 'drop',
                          onPressed: () {
                            context
                                .read<CalcBloc>()
                                .add(FilterElementAdded(type: FilterType.drop));
                          },
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'keep',
                          onPressed: () {
                            context
                                .read<CalcBloc>()
                                .add(FilterElementAdded(type: FilterType.keep));
                          },
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'lowest',
                          onPressed: () {
                            context.read<CalcBloc>().add(FilterConditionAdded(
                                condition: FilterCondition.lowest));
                          },
                          aspectRatio: 1.8,
                          textScaleFactor: 1,
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '÷',
                          onPressed: () {
                            context
                                .read<CalcBloc>()
                                .add(OperatorAdded(operator: Operator.divided));
                          },
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
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '7')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '8',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '8')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '9',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '9')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '×',
                          onPressed: () {
                            context.read<CalcBloc>().add(
                                OperatorAdded(operator: Operator.multiply));
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '4',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '4')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '5',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '5')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '6',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '6')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '−',
                          onPressed: () {
                            context
                                .read<CalcBloc>()
                                .add(OperatorAdded(operator: Operator.minus));
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '1',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '1')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '2',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '2')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '3',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '3')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '+',
                          onPressed: () {
                            context
                                .read<CalcBloc>()
                                .add(OperatorAdded(operator: Operator.plus));
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CalcButton(
                          childText: '0',
                          onPressed: () {
                            context.read<CalcBloc>().add(NumberAdded(
                                element: NumberElement(content: '0')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'none',
                          onPressed: () {},
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: 'dN',
                          onPressed: () {
                            context.read<CalcBloc>().add(
                                DiceAdded(element: DiceElement(content: '')));
                          },
                        )),
                        Expanded(
                            child: CalcButton(
                          childText: '=',
                          onPressed: () {
                            context.read<CalcBloc>().add(Calculate());
                          },
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
