part of 'history_bloc.dart';

@immutable
sealed class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<WorkoutSession> sessions;
  HistoryLoaded({required this.sessions});
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError({required this.message});
}
