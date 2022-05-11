part of 'calc_bloc.dart';

@immutable
abstract class CalcState extends Equatable {
  final String equationScreen;
  final String resultScreen;

  const CalcState(this.equationScreen, this.resultScreen);

  @override
  List<Object> get props => [equationScreen, resultScreen];
}

class CalcInitState extends CalcState {
  const CalcInitState() : super('', '0');
}

class CalcInputState extends CalcState {
  const CalcInputState(String equationScreen, String resultScreen)
      : super(equationScreen, resultScreen);
}

class CalcFinishedState extends CalcState {
  const CalcFinishedState(String equationScreen, String resultScreen)
      : super(equationScreen, resultScreen);
}
