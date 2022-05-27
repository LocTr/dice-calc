part of 'calc_bloc.dart';

@immutable
abstract class CalcEvent extends Equatable {
  const CalcEvent();

  @override
  List<Object> get props => [];
}

class NumberElementAdded extends CalcEvent {
  final NumberElement element;

  const NumberElementAdded({required this.element});

  @override
  List<Object> get props => [element];
}

class DiceElementAdded extends CalcEvent {
  final DiceElement element;

  const DiceElementAdded({required this.element});

  @override
  List<Object> get props => [element];
}

class ElementRemoved extends CalcEvent {
  const ElementRemoved();
}

class OperatorElementAdded extends CalcEvent {
  final OperatorElement element;

  const OperatorElementAdded({required this.element});

  @override
  List<Object> get props => [element];
}

class FilterElementAdded extends CalcEvent {
  final FilterElement element;

  const FilterElementAdded({required this.element});

  @override
  List<Object> get props => [element];
}
