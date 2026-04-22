import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/body_metric.dart';
import 'package:beyou/features/fitness/models/workout_session.dart';
import 'package:meta/meta.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final FitnessRepository repository;

  ProgressBloc({required this.repository}) : super(ProgressInitial()) {
    on<LoadProgressEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadProgressEvent event, Emitter<ProgressState> emit) async {
    emit(ProgressLoading());
    try {
      final sessions = await repository.loadWorkoutHistory(limit: 90);
      final metrics = await repository.loadBodyMetrics(limit: 90);
      emit(ProgressLoaded(sessions: sessions, metrics: metrics));
    } catch (e) {
      emit(ProgressError(message: e.toString()));
    }
  }
}
