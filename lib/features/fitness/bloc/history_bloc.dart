import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/workout_session.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final FitnessRepository repository;

  HistoryBloc({required this.repository}) : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final sessions = await repository.loadWorkoutHistory();
      emit(HistoryLoaded(sessions: sessions));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
