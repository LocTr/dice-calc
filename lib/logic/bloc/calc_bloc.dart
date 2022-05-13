import 'package:bloc/bloc.dart';
import 'package:dice_calc/model/element.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(const CalcState()) {
    on<NumberElementAdded>(_onNumberElementAdded);
    // on<CharacterRemoved>(_onCharacterRemoved);
  }

  void _onNumberElementAdded(
      NumberElementAdded event, Emitter<CalcState> emit) {
    if (state.elementList.isEmpty) {
      emit(CalcState(
        elementList: [event.element],
        resultScreen: '',
      ));
    } else if (state.elementList.last is NumberElement) {
      //   NumberElement lastElement = (state.elementList.last as NumberElement)
      //       .merge(element: event.element);
      //   List<Element> tempList = state.elementList
      //     ..removeLast()
      //     ..add(lastElement);
      //   emit(CalcState(elementList: tempList));
      // }
      NumberElement lastElement = state.elementList.last as NumberElement;

      emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(lastElement.merge(element: event.element))));
    }
  }

  // void _onCharacterRemoved(CharacterRemoved event, Emitter<CalcState> emit) {
  //   final equationScreen = state.equationScreen;
  //   emit(CalcInputState(equationScreen.substring(0, equationScreen.length - 1),
  //       state.resultScreen));
  // }
}
