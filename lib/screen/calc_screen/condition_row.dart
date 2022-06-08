import 'package:dice_calc/logic/calc_bloc/calc_bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/widgets/chip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConditionRow extends StatelessWidget {
  const ConditionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    Iterable<Widget> renderButton() sync* {
      var calcState = context.read<CalcBloc>().state;
      if (calcState.elementList.isNotEmpty) {
        switch (calcState.elementList.last.runtimeType) {
          case DiceElement:
            yield ChipButton(label: 'drop');
            yield ChipButton(label: 'keep');
            yield ChipButton(label: 'reroll');
            yield ChipButton(label: 'explode');
            break;
          case FilterElement:
            yield ChipButton(label: 'or more');
            yield ChipButton(label: 'or less');
            yield ChipButton(label: 'only');
            break;
          case RerollElement:
            break;
          default:
        }
      }
    }

    return Row(
      children: renderButton().toList(),
    );
  }
}
