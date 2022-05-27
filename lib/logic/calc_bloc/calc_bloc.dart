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
    on<ElementRemoved>(_onElementRemoved);
    on<OperatorElementAdded>(_onOperatorElementAdded);
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
    switch (currentList.last.runtimeType) {
      case (NumberElement):
        final NumberElement lastElement =
            state.elementList.last as NumberElement;
        final NumberElement newElement =
            NumberElement(content: lastElement.content + event.element.content);

        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (DiceElement):
        final DiceElement lastElement = state.elementList.last as DiceElement;
        final DiceElement newElement =
            DiceElement(content: lastElement.content + event.element.content);

        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (FilterElement):
        var lastElement =
            state.elementList.last as FilterElement;
            final FilterElement
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

  void _onElementRemoved(ElementRemoved event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    switch (currentList.last.runtimeType) {
      case NumberElement:
        final lastElement = currentList.last as NumberElement;
        if (lastElement.content.length == 1) {
          emit(state.copyWith(
            elementList: List.of(state.elementList)..removeLast(),
          ));
        } else {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(lastElement.copyWith(
                    content: lastElement.content
                        .substring(0, lastElement.content.length - 1)))));
        }
        break;
      case DiceElement:
        final lastElement = currentList.last as DiceElement;
        if (lastElement.content.isEmpty) {
          emit(state.copyWith(
            elementList: List.of(state.elementList)..removeLast(),
          ));
        } else {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(lastElement.copyWith(
                    content: lastElement.content
                        .substring(0, lastElement.content.length - 1)))));
        }
        break;
      default:
        emit(state.copyWith(
          elementList: List.of(state.elementList)..removeLast(),
        ));
        return;
    }
  }

  void _onOperatorElementAdded(
      OperatorElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is OperatorElement) {
      emit(state.copyWith(
        elementList: List.of(state.elementList)
          ..removeLast()
          ..add(event.element),
      ));
    } else {
      emit(state.copyWith(
        elementList: List.of(state.elementList)..add(event.element),
      ));
    }
  }
}
