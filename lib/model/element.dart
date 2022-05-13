import 'package:equatable/equatable.dart';

abstract class Element extends Equatable {
  final String content;
  const Element({required this.content});

  @override
  List<Object> get props => [content];
}

class NumberElement extends Element {
  const NumberElement({required String content}) : super(content: content);

  NumberElement merge({required NumberElement element}) {
    return NumberElement(
      content: content + element.content,
    );
  }

  @override
  List<Object> get props => [content];
}

class DiceElement extends Element {
  final String prefix = 'd';
  const DiceElement({required String content}) : super(content: content);
}

class OperatorElement extends Element {
  const OperatorElement({required String content}) : super(content: content);
}
