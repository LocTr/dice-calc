part of 'calc_bloc.dart';

@immutable
abstract class CalcEvent extends Equatable {
  const CalcEvent();

  @override
  List<Object> get props => [];
}

class NumberAdded extends CalcEvent {
  final NumberElement element;

  const NumberAdded({required this.element});

  @override
  List<Object> get props => [element];
}

class DiceAdded extends CalcEvent {
  final DiceElement element;

  const DiceAdded({required this.element});

  @override
  List<Object> get props => [element];
}

class ElementRemoved extends CalcEvent {
  const ElementRemoved();
}

class OperatorAdded extends CalcEvent {
  final Operator operator;

  const OperatorAdded({required this.operator});

  @override
  List<Object> get props => [operator];
}

class FilterElementAdded extends CalcEvent {
  final FilterType type;

  const FilterElementAdded({required this.type});

  @override
  List<Object> get props => [type];
}

class FilterConditionAdded extends CalcEvent {
  final FilterCondition condition;
  const FilterConditionAdded({required this.condition});

  @override
  List<Object> get props => [condition];
}

class Calculate extends CalcEvent {
  const Calculate();
}
