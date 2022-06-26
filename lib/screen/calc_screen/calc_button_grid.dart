import 'package:dice_calc/bloc/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/bloc/history_cubit/history_cubit.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:dice_calc/screen/calc_screen/condition_row.dart';
import 'package:dice_calc/screen/popup/history_dialog.dart';
import 'package:dice_calc/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcButtonGrid extends StatelessWidget {
  const CalcButtonGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              ConditionRow(),
            ],
          ),
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
                child: CalcButton(
              child: const Icon(Icons.access_time_outlined),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => HistoryCubit(),
                        child: const HistoryDialog(),
                      );
                    });
              },
            )),
            Expanded(
                child: CalcButton(
              childText: 'C',
              onPressed: () {
                context.read<CalcBloc>().add(const ElementCleared());
              },
            )),
            Expanded(
                child: CalcButton(
              childText: 'CE',
              onPressed: () {
                context.read<CalcBloc>().add(const ElementRemoved());
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '\u00f7',
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
              childText: '7',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 7)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '8',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 8)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '9',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 9)));
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
              childText: '4',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 4)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '5',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 5)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '6',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 6)));
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
              childText: '1',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 1)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '2',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 2)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '3',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 3)));
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
        Row(
          children: [
            const Expanded(
                child: CalcButton(
              child: Icon(Icons.favorite_border),
            )),
            Expanded(
                child: CalcButton(
              childText: '0',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const NumberAdded(element: NumberElement(content: 0)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: 'dN',
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const DiceAdded(element: DiceElement(content: 0)));
              },
            )),
            Expanded(
                child: CalcButton(
              childText: '=',
              onPressed: () {
                context.read<CalcBloc>().add(const Calculate());
              },
            )),
          ],
        ),
      ],
    );
  }
}
