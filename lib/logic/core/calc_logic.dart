import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';

int calculate(List<Element> input) {
  List<Element> list = List.of(input);
  list = _reduceDice(list);

  list = _reduceOperator(list);

  int result = 0;

  result = (list.first as NumberElement).value;
  return result;
}

List<Element> _reduceDice(List<Element> input) {
  List<Element> list = List.of(input);
  _roll(int diceValue, int numberOfDice) sync* {
    for (var i = 0; i < numberOfDice; i++) {
      final result = Random().nextInt(diceValue) + 1;
      yield result;
    }
  }

  for (var i = 0; i < list.length; i++) {
    var result = const Iterable<int>.empty();
    if (list[i] is! DiceElement) continue;
    var currentDice = list[i] as DiceElement;

    if (i == 0) {
      result = _roll(currentDice.value, 1);
      list[i] = NumberElement(content: result.first.toString());
    } else if (list[i - 1] is! NumberElement) {
      result = _roll(currentDice.value, 1);
      list[i] = NumberElement(content: result.first.toString());
    } else {
      result = _roll(currentDice.value, (list[i - 1] as NumberElement).value);
      int intResult =
          result.fold(0, (previousValue, element) => previousValue + element);
      list[i] = NumberElement(content: intResult.toString());
      list.removeAt(i - 1);
    }
  }
  return list;
}

List<Element> _reduceOperator(List<Element> input) {
  List<Element> list = List.of(input);
  //Reduce multiply operator first
  for (var i = 0; i < list.length; i++) {
    if (list[i] is! OperatorElement) continue;
    var currElement = list[i] as OperatorElement;
    if (currElement.operator == Operator.multiply) {
      int result = (list[i - 1] as NumberElement).value *
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    } else if (currElement.operator == Operator.divided) {
      int result = (list[i - 1] as NumberElement).value ~/
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    }
  }
  //Reduce add and abstract operator
  for (var i = 0; i < list.length; i++) {
    if (list[i] is! OperatorElement) continue;
    var currElement = list[i] as OperatorElement;
    if (currElement.operator == Operator.plus) {
      int result = (list[i - 1] as NumberElement).value +
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    } else if (currElement.operator == Operator.minus) {
      int result = (list[i - 1] as NumberElement).value -
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    }
  }
  return list;
}
