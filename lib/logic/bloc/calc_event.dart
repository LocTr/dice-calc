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

class CharacterRemoved extends CalcEvent {
  const CharacterRemoved();
}
