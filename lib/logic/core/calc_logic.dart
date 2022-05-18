import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';

void main() {
  List<Element> input = const [
    NumberElement(content: '6'),
    DiceElement(content: '6'),
  ];
  print(rollDices(input));
}

List<String> addChar(String input) {
  List<String> result = [];
  return result;
}

int rollDices(List<Element> input) {
  int result = 0;
  {
    List<int> diceResult = [];
    var currentOperator = Operator.none;
    var currentMultiplier = 1;
    for (var i = 0; i < input.length; i++) {
      var currentElement = input[i];
      switch (currentElement.runtimeType) {
        case NumberElement:
          currentMultiplier = int.parse(currentElement.content);
          break;
        case DiceElement:
          diceResult += _diceProcess(int.parse(currentElement.content),
                  currentMultiplier, currentOperator)
              .toList();
          break;
      }
    }
    result =
        diceResult.fold(0, (previousValue, element) => previousValue + element);
  }

  return result;
}

Iterable<int> _diceProcess(
    int numberOfSide, int currentMultiplier, Operator operator) sync* {
  switch (operator) {
    case Operator.plus:
      break;
    case Operator.none:
      for (var i = 0; i < currentMultiplier; i++) {
        final result = Random().nextInt(numberOfSide) + 1;
        print('this dice return ' + result.toString());
        yield (result);
      }
      break;
    default:
  }
}
