import 'package:bloc/bloc.dart';
import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(const CalcState()) {
    on<NumberAdded>(_onNumberElementAdded);
    on<DiceAdded>(_onDiceElementAdded);
    on<ElementRemoved>(_onElementRemoved);
    on<OperatorAdded>(_onOperatorElementAdded);
    on<FilterConditionAdded>(_onFilterConditionAdded);
    on<FilterElementAdded>(_onFilterElementAdded);
    on<Calculate>(_onCalculate);
  }

  void _onNumberElementAdded(NumberAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;
    if (currentList.isEmpty) {
      emit(CalcState(
        elementList: [event.element],
        resultScreen: state.resultScreen,
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
        var lastElement = state.elementList.last as FilterElement;
        final newElement = FilterElement(
          content: lastElement.content + event.element.content,
          type: lastElement.type,
          filterCondition: lastElement.filterCondition,
        );

        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (OperatorElement):
        emit(state.copyWith(
          elementList: List.of(state.elementList)..add(event.element),
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

  void _onDiceElementAdded(DiceAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;
    if (currentList.isNotEmpty) {
      if (currentList.last is DiceElement) return;
    }

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
      case FilterElement:
        final lastElement = currentList.last as FilterElement;
        if (lastElement.filterCondition != FilterCondition.none) {
          emit(state.copyWith(
            elementList: List.of(state.elementList)
              ..removeLast()
              ..add(FilterElement(
                content: lastElement.content,
                type: lastElement.type,
                filterCondition: FilterCondition.none,
              )),
          ));
        } else if (lastElement.content.isEmpty) {
          emit(state.copyWith(
              elementList: List.of(state.elementList)..removeLast()));
        } else {
          emit(state.copyWith(
            elementList: List.of(state.elementList)
              ..removeLast()
              ..add(FilterElement(
                type: lastElement.type,
                filterCondition: lastElement.filterCondition,
                content: lastElement.content
                    .substring(0, lastElement.content.length - 1),
              )),
          ));
        }
        break;
      default:
        emit(state.copyWith(
          elementList: List.of(state.elementList)..removeLast(),
        ));
        return;
    }
  }

  void _onOperatorElementAdded(OperatorAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    final opElement = OperatorElement(operator: event.operator);
    if (currentList.last is OperatorElement) {
      emit(state.copyWith(
        elementList: List.of(state.elementList)
          ..removeLast()
          ..add(opElement),
      ));
    } else {
      emit(state.copyWith(
        elementList: List.of(state.elementList)..add(opElement),
      ));
    }
  }

  void _onFilterConditionAdded(
      FilterConditionAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is FilterElement) {
      final lastElement = currentList.last as FilterElement;
      final newElement = FilterElement(
        content: lastElement.content,
        type: lastElement.type,
        filterCondition: event.condition,
      );
      emit(state.copyWith(
        elementList: List.of(state.elementList)
          ..removeLast()
          ..add(newElement),
      ));
    }
    return;
  }

  void _onFilterElementAdded(
      FilterElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is DiceElement) {
      final newElement = FilterElement(
        content: '',
        filterCondition: FilterCondition.none,
        type: event.type,
      );
      emit(state.copyWith(
        elementList: List.of(state.elementList)..add(newElement),
      ));
    }
    return;
  }

  void _onCalculate(Calculate event, Emitter<CalcState> emit) {
    int result = calculate(state.elementList);

    emit(state.copyWith(resultScreen: result.toString()));
    return;
  }
}
