abstract class CalcEvent {}

class AddCharEvent extends CalcEvent {
  AddCharEvent(this.char);
  final String char;
}

class ClearScreenEvent extends CalcEvent {}
