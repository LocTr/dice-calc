import 'package:bloc/bloc.dart';
import 'package:dice_calc/logic/core/calc_logic.dart';
import 'package:dice_calc/logic/persistence/transaction.dart';
import 'package:dice_calc/model/element.dart';
import 'package:dice_calc/model/enums.dart';
import 'package:dice_calc/model/exception/dice_exception.dart';
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
    on<RerollElementAdded>(_onRerollElementAdded);
    on<RerollConditionAdded>(_onRerollConditionAdded);
    on<RerollTimesAdded>(_onRerollTimesAdded);
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

    final lastElement = currentList.last;

    if (lastElement.content == 0 && event.element.content == 0) return;

    switch (currentList.last.runtimeType) {
      case (NumberElement):
        final NumberElement lastElement =
            state.elementList.last as NumberElement;

        final NumberElement newElement = NumberElement(
            content: lastElement.content * 10 + event.element.content);

        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (DiceElement):
        final DiceElement newElement = DiceElement(
            content: lastElement.content * 10 + event.element.content);
        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (FilterElement):
        var lastElement = state.elementList.last as FilterElement;
        final newElement = FilterElement(
          content: lastElement.content * 10 + event.element.content,
          type: lastElement.type,
          filterCondition: lastElement.filterCondition,
        );
        emit(state.copyWith(
          elementList: List.of(state.elementList)
            ..removeLast()
            ..add(newElement),
        ));
        break;
      case (RerollElement):
        var lastElement = state.elementList.last as RerollElement;

        final RerollElement newElement;
        if (lastElement.condition == RerollCondition.none) {
          newElement = RerollElement(
            type: lastElement.type,
            timesContent: lastElement.timesContent * 10 + event.element.content,
            content: lastElement.content,
            condition: lastElement.condition,
            times: RerollTimes.specific,
          );
        } else {
          newElement = RerollElement(
            type: lastElement.type,
            content: lastElement.content * 10 + event.element.content,
            condition: lastElement.condition,
            timesContent: lastElement.timesContent,
            times: lastElement.times,
          );
        }
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
        if (lastElement.content < 10) {
          emit(state.copyWith(
            elementList: List.of(state.elementList)..removeLast(),
          ));
        } else {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(
                    lastElement.copyWith(content: lastElement.content ~/ 10))));
        }
        break;
      case DiceElement:
        final lastElement = currentList.last as DiceElement;
        if (lastElement.content == 0) {
          emit(state.copyWith(
            elementList: List.of(state.elementList)..removeLast(),
          ));
        } else {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(DiceElement(content: lastElement.content ~/ 10))));
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
        } else if (lastElement.content == 0) {
          emit(state.copyWith(
              elementList: List.of(state.elementList)..removeLast()));
        } else {
          emit(state.copyWith(
            elementList: List.of(state.elementList)
              ..removeLast()
              ..add(FilterElement(
                type: lastElement.type,
                filterCondition: lastElement.filterCondition,
                content: lastElement.content ~/ 10,
              )),
          ));
        }
        break;
      case RerollElement:
        final lastElement = currentList.last as RerollElement;
        if (lastElement.condition != RerollCondition.none) {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(lastElement.copyWith(
                  condition: RerollCondition.none,
                ))));
        } else if (lastElement.content != 0) {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(
                    lastElement.copyWith(content: lastElement.content ~/ 10))));
        } else if (lastElement.timesContent != 0) {
          emit(state.copyWith(
              elementList: List.of(state.elementList)
                ..removeLast()
                ..add(lastElement.copyWith(
                    timesContent: lastElement.timesContent ~/ 10))));
        } else {
          emit(state.copyWith(
            elementList: List.of(state.elementList)..removeLast(),
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

  void _onFilterElementAdded(
      FilterElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is DiceElement) {
      final newElement = FilterElement(
        content: 0,
        filterCondition: FilterCondition.none,
        type: event.type,
      );
      emit(state.copyWith(
        elementList: List.of(state.elementList)..add(newElement),
      ));
    }
    return;
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

  void _onRerollElementAdded(
      RerollElementAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is DiceElement) {
      final newElement = RerollElement(
          content: 0,
          type: event.type,
          condition: RerollCondition.none,
          times: RerollTimes.none,
          timesContent: 0);
      emit(state.copyWith(
        elementList: List.of(state.elementList)..add(newElement),
      ));
    }
  }

  void _onRerollConditionAdded(
      RerollConditionAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is RerollElement) {
      final lastElement = currentList.last as RerollElement;
      emit(state.copyWith(
        elementList: List.of(state.elementList)
          ..removeLast()
          ..add(lastElement.copyWith(condition: event.condition)),
      ));
    }
  }

  void _onRerollTimesAdded(RerollTimesAdded event, Emitter<CalcState> emit) {
    final currentList = state.elementList;

    if (currentList.isEmpty) return;

    if (currentList.last is RerollElement) {
      final lastElement = currentList.last as RerollElement;
      emit(state.copyWith(
        elementList: List.of(state.elementList)
          ..removeLast()
          ..add(lastElement.copyWith(times: event.times)),
      ));
    }
  }

  void _onCalculate(Calculate event, Emitter<CalcState> emit) {
    try {
      if (state.elementList.isEmpty) return;

      int result = calculate(state.elementList);

      emit(state.copyWith(resultScreen: result.toString()));

      HistoryDB.put(equator: state.toString(), result: result.toString());

      return;
    } on DiceException catch (e) {
      emit(state.copyWith(resultScreen: e.cause.toString()));
    }
  }
}
