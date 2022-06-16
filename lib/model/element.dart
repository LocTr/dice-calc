import 'package:dice_calc/model/enums.dart';
import 'package:equatable/equatable.dart';

abstract class Element extends Equatable {
  final int content;
  const Element({required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() {
    return content.toString();
  }
}

class NumberElement extends Element {
  const NumberElement({required int content}) : super(content: content);

  NumberElement copyWith({required int content}) {
    return NumberElement(content: content);
  }

  @override
  List<Object> get props => [content];
}

class DiceElement extends Element {
  const DiceElement({required int content}) : super(content: content);

  @override
  String toString() {
    return content == 0 ? 'd' : 'd' + content.toString();
  }
}

class ProcessedDiceElement extends Element {
  final int result;
  const ProcessedDiceElement({required int content, required this.result})
      : super(content: content);
}

class OperatorElement extends Element {
  final Operator operator;

  const OperatorElement({required this.operator}) : super(content: 0);

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
      {required int content,
      required this.type,
      this.filterCondition = FilterCondition.none})
      : super(content: content);

  @override
  String toString() {
    final contentStr = content == 0 ? '' : content.toString();

    if (filterCondition == FilterCondition.none) {
      return ' ${type.name} $contentStr ';
    } else {
      return ' ${type.name} $contentStr ${filterCondition.name}';
    }
  }

  @override
  List<Object> get props => [content, type, filterCondition];
}

class RerollElement extends Element {
  final RerollType type;
  final RerollCondition condition;
  final RerollTimes times;
  final int timesContent;

  const RerollElement(
      {required int content,
      required this.type,
      required this.condition,
      required this.times,
      required this.timesContent})
      : super(content: content);

  RerollElement copyWith({
    int? content,
    RerollType? type,
    RerollCondition? condition,
    RerollTimes? times,
    int? timesContent,
  }) {
    return RerollElement(
        content: content ?? this.content,
        type: type ?? this.type,
        condition: condition ?? this.condition,
        times: times ?? this.times,
        timesContent: timesContent ?? this.timesContent);
  }

  @override
  String toString() {
    final String contentStr;
    final String timesContentStr;

    switch (times) {
      case RerollTimes.always:
        timesContentStr = 'always';
        break;
      case RerollTimes.specific:
        timesContentStr = '$timesContent times';
        break;
      case RerollTimes.none:
        timesContentStr = '';
        break;
    }

    switch (condition) {
      case RerollCondition.none:
        contentStr = '';
        break;
      case RerollCondition.only:
        contentStr = 'on $content';
        break;
      case RerollCondition.more:
        contentStr = 'on $content or more';
        break;
      case RerollCondition.less:
        contentStr = 'on $content or less';
        break;
    }
    return ' ${type.name} $timesContentStr $contentStr';
  }

  @override
  List<Object> get props => [content, type, condition, times, timesContent];
}
