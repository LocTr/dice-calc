part of 'history_cubit.dart';

class HistoryState extends Equatable {
  final Map data;

  const HistoryState({required this.data});

  @override
  List<Object> get props => [data];
}
