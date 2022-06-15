import 'dart:io';
import 'dart:math';

import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:dice_calc/model/exception/dice_exception.dart';

// void main(List<String> args) {
//   List<Element> list = const [
//     NumberElement(content: '1'),
//     DiceElement(content: '2'),
//     RerollElement(
//         content: '2',
//         type: RerollType.explode,
//         condition: RerollCondition.only,
//         times: RerollTimes.specific,
//         timesContent: '3'),
//   ];
//   for (var i = 0; i < 10; i++) {
//     int result = calculate(list);
//   }
// }

int calculate(List<Element> input) {
  List<Element> list = List.of(input);
  list = _reduceDice(list);

  list = _reduceOperator(list);

  int result = 0;

  result = (list.first as NumberElement).content;
  return result;
}

List<Element> _reduceDice(List<Element> input) {
  _roll(int diceValue) {
    //default value (0) is d6
    return Random().nextInt(diceValue == 0 ? 6 : diceValue) + 1;
  }

  List<int> _filter(Iterable<int> diceset, FilterElement filterElement) {
    if (diceset.length <= filterElement.content) {
      throw DiceException('range err');
    } else if (filterElement.content == 0) {
      throw DiceException('missing arg');
    }

    final list = diceset.toList()..sort((a, b) => a.compareTo(b));
    if (filterElement.type == FilterType.drop) {
      if (filterElement.filterCondition == FilterCondition.highest) {
        return list.sublist(0, list.length - filterElement.content);
      } else {
        return list.sublist(0 + filterElement.content);
      }
    } else {
      if (filterElement.filterCondition == FilterCondition.lowest) {
        return list.sublist(0, filterElement.content);
      } else {
        return list.sublist(list.length - filterElement.content, list.length);
      }
    }
  }

  List<int> _reroll(
      Iterable<int> diceset, int diceValue, RerollElement rerollElement) {
    var result = diceset.toList();
    for (var dice in result) {
      stdout.write(dice.toString() + ', ');
    }

    switch (rerollElement.condition) {
      case (RerollCondition.only):
        for (int i = 0; i < result.length; i++) {
          int times = 0;
          while (result[i] == rerollElement.content &&
              times < rerollElement.timesContent) {
            result[i] = _roll(diceValue);
            for (var dice in result) {
              stdout.write(dice.toString() + ', ');
            }
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
      case (RerollCondition.less):
        for (int i = 0; i < result.length; i++) {
          if (diceValue <= rerollElement.content) {
            throw DiceException('range err');
          }

          int times = 0;
          while (result[i] <= rerollElement.content &&
              times < rerollElement.timesContent) {
            result[i] = _roll(diceValue);
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
      case (RerollCondition.more):
        for (int i = 0; i < result.length; i++) {
          if (rerollElement.content <= 1) {
            throw DiceException('range err');
          }
          int times = 0;
          while (result[i] >= rerollElement.content &&
              times < rerollElement.timesContent) {
            result[i] = _roll(diceValue);
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
    }
    return result;
  }

  List<int> _explode(
      Iterable<int> diceset, int diceValue, RerollElement rerollElement) {
    var result = diceset.toList();
    var explodedDice = <int>[];
    for (var dice in result) {
      stdout.write(dice.toString() + ', ');
    }

    switch (rerollElement.condition) {
      case (RerollCondition.only):
        for (int i = 0; i < result.length; i++) {
          int times = 0;
          while (result[i] == rerollElement.content &&
              times < rerollElement.timesContent) {
            explodedDice.add(result[i]);
            result[i] = _roll(diceValue);
            for (var dice in result) {
              stdout.write(dice.toString() + ', ');
            }
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
      case (RerollCondition.less):
        for (int i = 0; i < result.length; i++) {
          if (diceValue <= rerollElement.content) {
            throw DiceException('range err');
          }

          int times = 0;
          while (result[i] <= rerollElement.content &&
              times < rerollElement.timesContent) {
            explodedDice.add(result[i]);
            result[i] = _roll(diceValue);
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
      case (RerollCondition.more):
        for (int i = 0; i < result.length; i++) {
          if (rerollElement.content <= 1) {
            throw DiceException('range err');
          }
          int times = 0;
          while (result[i] >= rerollElement.content &&
              times < rerollElement.timesContent) {
            explodedDice.add(result[i]);
            result[i] = _roll(diceValue);
            (rerollElement.times != RerollTimes.always) ? times++ : null;
          }
        }
        break;
    }
    result.addAll(explodedDice);
    return result;
  }

  _reduce() {
    List<Element> list = List.of(input);

    for (var i = 0; i < list.length; i++) {
      if (list[i] is! DiceElement) continue;

      var currentDice = list[i] as DiceElement;
      if (i == 0) {
        list[i] = NumberElement(content: _roll(currentDice.content));
      } else if (list[i - 1] is! NumberElement) {
        list[i] = NumberElement(content: _roll(currentDice.content));
      } else {
        var result = <int>[];
        for (var num = 0; num < (list[i - 1] as NumberElement).content; num++) {
          result.add(_roll(currentDice.content));
        }
        if (i != list.length - 1) {
          if (list[i + 1] is FilterElement) {
            result = _filter(result, list[i + 1] as FilterElement);
            list.removeAt(i + 1);
          } else if (list[i + 1] is RerollElement) {
            if ((list[i + 1] as RerollElement).type == RerollType.reroll) {
              result = _reroll(
                  result, currentDice.content, list[i + 1] as RerollElement);
            } else {
              result = _explode(
                  result, currentDice.content, list[i + 1] as RerollElement);
            }
          }
        }
        final int intResult =
            result.fold(0, (previousValue, element) => previousValue + element);
        list[i] = NumberElement(content: intResult);
        list.removeAt(i - 1);
      }
    }
    return list;
  }

  return _reduce();
}

List<Element> _reduceOperator(List<Element> input) {
  List<Element> list = List.of(input);
  //Reduce multiply operator first
  for (var i = 0; i < list.length; i++) {
    if (list[i] is! OperatorElement) continue;
    var currElement = list[i] as OperatorElement;
    if (currElement.operator == Operator.multiply) {
      int result = (list[i - 1] as NumberElement).content *
          (list[i + 1] as NumberElement).content;
      list[i] = NumberElement(content: result);
      list.removeAt(i + 1);
      list.removeAt(i - 1);
      i--;
    } else if (currElement.operator == Operator.divided) {
      int result = (list[i - 1] as NumberElement).content ~/
          (list[i + 1] as NumberElement).content;
      list[i] = NumberElement(content: result);
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
      int result = (list[i - 1] as NumberElement).content +
          (list[i + 1] as NumberElement).content;
      list[i] = NumberElement(content: result);
      list.removeAt(i + 1);
      list.removeAt(i - 1);
      i--;
    } else if (currElement.operator == Operator.minus) {
      int result = (list[i - 1] as NumberElement).content -
          (list[i + 1] as NumberElement).content;
      list[i] = NumberElement(content: result);
      list.removeAt(i + 1);
      list.removeAt(i - 1);
      i--;
    }
  }
  return list;
}
