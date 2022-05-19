import 'package:dice_calc/model/enums.dart';
import 'package:equatable/equatable.dart';

abstract class Element extends Equatable {
  final String content;
  const Element({required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() {
    return content;
  }
}

class NumberElement extends Element {
  const NumberElement({required String content}) : super(content: content);

  NumberElement copyWith({required String content}) {
    return NumberElement(content: content);
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

  @override
  String toString() {
    return prefix + content;
  }
}

class OperatorElement extends Element {
  final Operator operator;

  const OperatorElement({required String content, required this.operator})
      : super(content: content);

  @override
  List<Object> get props => [content];

  @override
  String toString() {
    return content;
  }
}
