import 'package:equatable/equatable.dart';

abstract class Element extends Equatable {
  final String content;
  const Element(this.content);

  @override
  List<Object> get props => [content];
}

class NumberElement extends Element {
  const NumberElement(String content) : super(content);
}

class DiceElement extends Element {
  final String prefix = 'd';
  const DiceElement(String content) : super(content);
}

class OperatorElement extends Element {
  const OperatorElement(String content) : super(content);
}
