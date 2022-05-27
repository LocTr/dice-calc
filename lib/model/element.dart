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
  final String prefix = 'd';
  const DiceElement({required String content}) : super(content: content);

  DiceElement copyWith({required String content}) {
    return DiceElement(content: content);
  }

  int get value {
    return int.tryParse(content) ?? 6;
  }

  @override
  String toString() {
    return prefix + content.toString();
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
        return '+';
      case Operator.minus:
        return '-';
      case Operator.multiply:
        return 'x';
      case Operator.divided:
        return '/';
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
    return int.tryParse(content) ?? 0;
  }

  @override
  String toString() {
    if (filterCondition == FilterCondition.none) {
      return '${type.name} $content ';
    } else {
      return '${type.name} $content ${filterCondition.name}';
    }
  }

  @override
  List<Object> get props => [content, type, filterCondition];
}
