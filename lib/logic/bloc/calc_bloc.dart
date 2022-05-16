import 'package:bloc/bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(const CalcState()) {
    on<NumberElementAdded>(_onNumberElementAdded);
    on<DiceElementAdded>(_onDiceElementAdded);
    // on<CharacterRemoved>(_onCharacterRemoved);
  }

  void _onNumberElementAdded(
      NumberElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;
    if (currentList.isEmpty) {
      emit(CalcState(
        elementList: [event.element],
        resultScreen: '',
      ));
      return;
    }
    // switch case seems to look better
    switch (currentList.last.runtimeType) {
      case (NumberElement):
        NumberElement lastElement = state.elementList.last as NumberElement;
        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(
              lastElement.merge(content: event.element.content),
            ),
        ));
        break;
      case (DiceElement):
        DiceElement lastElement = state.elementList.last as DiceElement;
        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(
              lastElement.merge(content: event.element.content),
            ),
        ));
        break;
      default:
        emit(CalcState(
          elementList: [event.element],
          resultScreen: '',
        ));
    }
    return;
  }

  void _onDiceElementAdded(DiceElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;
    if (currentList.isEmpty) {
      emit(CalcState(
        elementList: [event.element],
        resultScreen: '',
      ));
      return;
    }
    if (currentList.last is DiceElement) return;
    emit(state.copyWith(
      elementList: List.of(state.elementList)..add(event.element),
    ));
    return;
  }

  // void _onCharacterRemoved(CharacterRemoved event, Emitter<CalcState> emit) {
  //   final equationScreen = state.equationScreen;
  //   emit(CalcInputState(equationScreen.substring(0, equationScreen.length - 1),
  //       state.resultScreen));
  // }
}
