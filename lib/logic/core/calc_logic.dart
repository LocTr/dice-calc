import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';

List<String> addChar(String input) {
  List<String> result = [];
  return result;
}

int calculate(List<Element> input) {
  List<Element> list = List.of(input);
  list = _reduceDice(list);

  list = _reduceOperator(list);

  int result = 0;

  result = int.parse(list.first.content);
  return result;
}

void main(List<String> args) {
  var input = const <Element>[DiceElement(content: '6')];
  var output = calculate(input);
  print('resuilt: ' + output.toString());
}

List<Element> _reduceDice(List<Element> input) {
  List<Element> list = List.of(input);
  _roll(String diceContent, int numberOfDice) sync* {
    for (var i = 0; i < numberOfDice; i++) {
      final result = Random().nextInt(int.tryParse(diceContent) ?? 6) + 1;
      print('dice result:' + result.toString());
      yield result;
    }
  }

  for (var i = 0; i < list.length; i++) {
    var result = const Iterable<int>.empty();
    if (list[i] is! DiceElement) continue;

    if (i == 0) {
      result = _roll(list[i].content, 1);
      list[i] = NumberElement(content: result.first.toString());
    } else if (list[i - 1] is! NumberElement) {
      result = _roll(list[i].content, 1);
      list[i] = NumberElement(content: result.first.toString());
    } else {
      result = _roll(list[i].content, int.parse(list[i - 1].content));
      int intResult =
          result.fold(0, (previousValue, element) => previousValue + element);
      print('3 d7 result: ' + intResult.toString());
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
      int result =
          int.parse(list[i - 1].content) * int.parse(list[i + 1].content);
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    } else if (currElement.operator == Operator.divided) {
      int result =
          int.parse(list[i - 1].content) ~/ int.parse(list[i + 1].content);
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
      int result =
          int.parse(list[i - 1].content) + int.parse(list[i + 1].content);
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    } else if (currElement.operator == Operator.minus) {
      int result =
          int.parse(list[i - 1].content) - int.parse(list[i + 1].content);
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
    }
  }
  return list;
}
