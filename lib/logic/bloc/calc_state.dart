part of 'calc_bloc.dart';

class CalcState extends Equatable {
  final List<Element> elementList;
  final String resultScreen;

  const CalcState({this.elementList = const [], this.resultScreen = ''});

  CalcState copyWith({
    List<Element>? elementList,
    String? resultScreen,
  }) {
    return CalcState(
      elementList: elementList ?? this.elementList,
      resultScreen: resultScreen ?? this.resultScreen,
    );
  }

  @override
  List<Object> get props => [elementList, resultScreen];
}
