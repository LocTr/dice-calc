import 'package:bloc/bloc.dart';
import 'package:dice_calc/logic/persistence/historyDB.dart';
import 'package:equatable/equatable.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryState(data: HistoryDB.readAll()));

  void clear() {
    HistoryDB.clear();
    emit(const HistoryState(data: {}));
  }
}
