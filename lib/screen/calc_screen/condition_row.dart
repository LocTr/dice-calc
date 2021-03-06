import 'package:dice_calc/bloc/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConditionRow extends StatelessWidget {
  const ConditionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> renderButton(CalcState state) sync* {
      if (state.elementList.isNotEmpty) {
        switch (state.elementList.last.runtimeType) {
          case DiceElement:
            yield TextButton(
              child: const Text('drop'),
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const FilterElementAdded(type: FilterType.drop));
              },
            );
            yield TextButton(
              child: const Text('keep'),
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const FilterElementAdded(type: FilterType.keep));
              },
            );
            yield TextButton(
              child: const Text('reroll'),
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const RerollElementAdded(type: RerollType.reroll));
              },
            );
            yield TextButton(
              child: const Text('explode'),
              onPressed: () {
                context
                    .read<CalcBloc>()
                    .add(const RerollElementAdded(type: RerollType.explode));
              },
            );
            break;
          case FilterElement:
            yield TextButton(
              child: const Text('highest'),
              onPressed: () {
                context.read<CalcBloc>().add(const FilterConditionAdded(
                    condition: FilterCondition.highest));
              },
            );
            yield TextButton(
              child: const Text('lowest'),
              onPressed: () {
                context.read<CalcBloc>().add(const FilterConditionAdded(
                    condition: FilterCondition.lowest));
              },
            );
            break;
          case RerollElement:
            yield TextButton(
              child: const Text('or more'),
              onPressed: () {
                context.read<CalcBloc>().add(const RerollConditionAdded(
                    condition: RerollCondition.more));
              },
            );
            yield TextButton(
              child: const Text('or less'),
              onPressed: () {
                context.read<CalcBloc>().add(const RerollConditionAdded(
                    condition: RerollCondition.less));
              },
            );
            break;
          default:
        }
      }
    }

    return BlocBuilder<CalcBloc, CalcState>(
      builder: (context, state) {
        return Row(children: renderButton(state).toList());
      },
    );
  }
}
