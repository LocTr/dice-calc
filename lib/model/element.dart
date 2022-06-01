import 'package:dice_calc/model/enums.dart';
import 'package:equatable/equatable.dart';

abstract class Element extends Equatable {
  final String content;
  const Element({required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() {
    return content.toString();
  }
}

class NumberElement extends Element {
  const NumberElement({required String content}) : super(content: content);

  NumberElement copyWith({required String content}) {
    return NumberElement(content: content);
  }

  int get value {
    return int.tryParse(content) ?? 1;
  }

  @override
  List<Object> get props => [content];
}

class DiceElement extends Element {
  const DiceElement({required String content}) : super(content: content);

  DiceElement copyWith({required String content}) {
    return DiceElement(content: content);
  }

  int get value {
    return int.tryParse(content) ?? 6;
  }

  @override
  String toString() {
    return 'd' + content.toString();
  }
}

class ProcessedDiceElement extends Element {
  final int result;
  const ProcessedDiceElement({required String content, required this.result})
      : super(content: content);

  int get value {
    return int.tryParse(content) ?? 6;
  }
}

class OperatorElement extends Element {
  final Operator operator;

  const OperatorElement({required this.operator}) : super(content: '');

  @override
  List<Object> get props => [operator];

  @override
  String toString() {
    switch (operator) {
      case Operator.plus:
        return ' + ';
      case Operator.minus:
        return ' \u2212 ';
      case Operator.multiply:
        return ' \u00d7 ';
      case Operator.divided:
        return ' ÷ ';
    }
  }
}

class FilterElement extends Element {
  final FilterType type;
  final FilterCondition filterCondition;

  const FilterElement(
      {required content,
      required this.type,
      this.filterCondition = FilterCondition.none})
      : super(content: content);

  int get value {
    return int.tryParse(content) ?? 1;
  }

  @override
  String toString() {
    if (filterCondition == FilterCondition.none) {
      return ' ${type.name} $content ';
    } else {
      return ' ${type.name} $content ${filterCondition.name}';
    }
  }

  @override
  List<Object> get props => [content, type, filterCondition];
}

class RerollElement extends Element {
  final RerollType type;
  final RerollCondition condition;
  final RerollTimes times;
  final String timesContent;

  const RerollElement(
      {required content,
      required this.type,
      required this.condition,
      required this.times,
      required this.timesContent})
      : super(content: content);

  int get timesValue {
    return int.tryParse(timesContent) ?? 0;
  }

  int get value {
    return int.tryParse(content) ?? 0;
  }
}
