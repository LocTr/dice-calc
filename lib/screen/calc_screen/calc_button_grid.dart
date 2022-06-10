import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:dice_calc/screen/calc_screen/condition_row.dart';
import 'package:dice_calc/screen/calc_screen/history_dialog.dart';
import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _State {
  none,
  filter,
  reroll,
}

class CalcButtonGrid extends StatelessWidget {
  const CalcButtonGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _State getCurrentState() {
      var result = _State.none;
      var calcState = context.read<CalcBloc>().state;
      if (calcState.elementList.isNotEmpty) {
        if (calcState.elementList.last is FilterElement) {
          result = _State.filter;
        }
        // else if (calcState.elementList.last is RerollElement) {
        //   result = _State.reroll
        // }
      }

      return result;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const ConditionRow(),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const HistoryDialog();
                      });
                },
                icon: const Icon(Icons.history)),
            IconButton(
                onPressed: () {
                  context.read<CalcBloc>().add(const ElementRemoved());
                },
                icon: const Icon(Icons.backspace_outlined)),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: CalcButton(
                childText: (() {
                  switch (getCurrentState()) {
                    case _State.none:
                      return 'drop';
                    case _State.filter:
                      return 'lowest';
                    case _State.reroll:
                      return 'none';
                  }
                }()),
                onPressed: () {
                  switch (getCurrentState()) {
                    case _State.none:
                      context
                          .read<CalcBloc>()
                          .add(const FilterElementAdded(type: FilterType.drop));
                      break;
                    case _State.filter:
                      context.read<CalcBloc>().add(const FilterConditionAdded(
                          condition: FilterCondition.lowest));
                      break;
                    default:
                  }
                },
                aspectRatio: 1.8,
                textScaleFactor: 1,
              ),
            ),
            Expanded(
                child: CalcButton(
              childText: (() {
                switch (getCurrentState()) {
                  case _State.none:
                    return 'keep';
                  case _State.filter:
                    return 'highest';
                  case _State.reroll:
                    return 'none';
                }
              }()),
              onPressed: () {
                switch (getCurrentState()) {
                  case _State.none:
                    context
                        .read<CalcBloc>()
                        .add(const FilterElementAdded(type: FilterType.keep));
                    break;
                  case _State.filter:
                    context.read<CalcBloc>().add(const FilterConditionAdded(
                        condition: FilterCondition.highest));
                    break;
                  default:
                }
              },
              aspectRatio: 1.8,
              textScaleFactor: 1,
            )),
            Expanded(
                child: CalcButton(
              childText: 'reroll',
              onPressed: () {
                // switch (getCurrentState()) {
                //   case _State.none:
                //     break;
                //   case _State.filter:
                //     context.read<CalcBloc>().add(const FilterConditionAdded(
                //         condition: FilterCondition.none));
                //     break;
                //   default:
                // }
                // context.read<CalcBloc>().add(const FilterConditionAdded(
                //     condition: FilterCondition.lowest));
              },
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
          ],
        ),
        Row(
          children: [
            Expanded(
                child: CalcButton(
              childText: '7',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '7')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '8',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '8')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '9',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '9')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '÷',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const OperatorAdded(operator: Operator.divided));
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
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '4')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '5',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '5')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '6',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '6')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '\u00d7',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const OperatorAdded(operator: Operator.multiply));
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
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '1')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '2',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '2')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '3',
              onPressed: () {
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '3')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '\u2212',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const OperatorAdded(operator: Operator.minus));
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
                context.read<CalcBloc>().add(
                    const NumberAdded(element: NumberElement(content: '0')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: 'dN',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const DiceAdded(element: DiceElement(content: '')));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '=',
              onPressed: () {
                context.read<CalcBloc>().add(const Calculate());
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '+',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const OperatorAdded(operator: Operator.plus));
              },
            )),
          ],
        ),
      ],
    );
  }
}
