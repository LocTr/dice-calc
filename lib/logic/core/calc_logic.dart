import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:dice_calc/model/exception/dice_exception.dart';

void main(List<String> args) {
  List<Element> list = const [
    NumberElement(content: '5'),
    DiceElement(content: ''),
    FilterElement(
      content: '2',
      type: FilterType.keep,
      filterCondition: FilterCondition.highest,
    ),
  ];
  int result = calculate(list);
  print(result);
}

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
    if (diceValue < 1) throw DiceException('');
    for (var i = 0; i < numberOfDice; i++) {
      final result = Random().nextInt(diceValue) + 1;
      yield result;
    }
  }

  List<int> _filter(Iterable<int> diceset, FilterElement filterElement) {
    final int filterValue = filterElement.value;
    final list = diceset.toList()..sort((a, b) => a.compareTo(b));
    if (filterElement.type == FilterType.drop) {
      if (filterElement.filterCondition == FilterCondition.highest) {
        return list.sublist(0, list.length - filterValue);
      } else {
        return list.sublist(0 + filterValue);
      }
    } else {
      if (filterElement.filterCondition == FilterCondition.lowest) {
        return list.sublist(0, filterValue);
      } else {
        return list.sublist(list.length - filterValue, list.length);
      }
    }
  }

  for (var i = 0; i < list.length; i++) {
    var result = List<int>.empty();
    if (list[i] is! DiceElement) continue;

    var currentDice = list[i] as DiceElement;
    if (i == 0) {
      result = _roll(currentDice.value, 1).toList();
      list[i] = NumberElement(content: result.first.toString());
    } else if (list[i - 1] is! NumberElement) {
      result = _roll(currentDice.value, 1).toList();
      list[i] = NumberElement(content: result.first.toString());
    } else {
      result = _roll(currentDice.value, (list[i - 1] as NumberElement).value)
          .toList();
      print('total dices:' + result.length.toString());
      if (i != list.length - 1) {
        if (list[i + 1] is FilterElement) {
          result = _filter(result, list[i + 1] as FilterElement);
          print('filtered dices:' + result.length.toString());
          list.removeAt(i + 1);
        }
      }
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
      i--;
    } else if (currElement.operator == Operator.divided) {
      int result = (list[i - 1] as NumberElement).value ~/
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
      i--;
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
      i--;
    } else if (currElement.operator == Operator.minus) {
      int result = (list[i - 1] as NumberElement).value -
          (list[i + 1] as NumberElement).value;
      list[i] = NumberElement(content: result.toString());
      list.removeAt(i + 1);
      list.removeAt(i - 1);
      i--;
    }
  }
  return list;
}
