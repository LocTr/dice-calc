part of 'calc_bloc.dart';

class CalcState extends Equatable {
  final List<Element> elementList;
  final String resultScreen;

  const CalcState({this.elementList = const [], this.resultScreen = '0'});

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

  @override
  String toString() {
    if (elementList.isEmpty) return '0';

    String result = '';
    for (var element in elementList) {
      result += element.toString();
    }
    return result;
  }
}
