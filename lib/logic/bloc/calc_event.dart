part of 'calc_bloc.dart';

@immutable
abstract class CalcEvent extends Equatable {
  const CalcEvent();

  @override
  List<Object> get props => [];
}

class CharacterAdded extends CalcEvent {
  final String character;

  const CharacterAdded({required this.character});

  @override
  List<Object> get props => [character];
}

class CharacterRemoved extends CalcEvent {
  const CharacterRemoved();
}
