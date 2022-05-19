import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';

List<String> addChar(String input) {
  List<String> result = [];
  return result;
}

int rollDices(List<Element> input) {
  int result = 0;
  {
    var currentOperator = Operator.none;
    var currentMultiplier = 1;
    for (var i = 0; i < input.length; i++) {
      var currentElement = input[i];
      switch (currentElement.runtimeType) {
        case NumberElement:
          currentMultiplier = int.parse(currentElement.content);
          break;
        case DiceElement:
          final rollResult = _diceProcess(
              int.parse(currentElement.content.isEmpty
                  ? '6'
                  : currentElement.content),
              currentMultiplier,
              currentOperator);
          result += rollResult.fold(
              0, (previousValue, element) => previousValue + element);
          currentMultiplier = result;
          break;
        case OperatorElement:
          currentMultiplier = 1;
          currentOperator = (currentElement as OperatorElement).operator;
      }
    }
  }

  return result;
}

Iterable<int> _diceProcess(
    int numberOfSide, int currentMultiplier, Operator operator) sync* {
  switch (operator) {
    case Operator.plus:
      yield currentMultiplier;
      break;
    case Operator.none:
      for (var i = 0; i < currentMultiplier; i++) {
        final result = Random().nextInt(numberOfSide) + 1;
        yield (result);
      }
      break;
    default:
  }
}
