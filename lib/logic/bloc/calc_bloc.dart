import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  CalcBloc() : super(const CalcInitState()) {
    on<CharacterAdded>(_onCharacterAdded);
    on<CharacterRemoved>(_onCharacterRemoved);
  }

  void _onCharacterAdded(CharacterAdded event, Emitter<CalcState> emit) {
    emit(CalcInputState(
        state.equationScreen + event.character, state.resultScreen));
  }

  void _onCharacterRemoved(CharacterRemoved event, Emitter<CalcState> emit) {
    final equationScreen = state.equationScreen;
    emit(CalcInputState(equationScreen.substring(0, equationScreen.length - 1),
        state.resultScreen));
  }
}
