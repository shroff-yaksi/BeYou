import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:meta/meta.dart';

part 'workout_detail_event.dart';
part 'workout_detail_state.dart';

class WorkoutDetailBloc extends Bloc<WorkoutDetailEvent, WorkoutDetailState> {
  final FitnessRepository repository;

  WorkoutDetailBloc({required this.repository}) : super(WorkoutDetailInitial()) {
    on<LoadWorkoutDetailEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadWorkoutDetailEvent event, Emitter<WorkoutDetailState> emit) async {
    emit(WorkoutDetailLoading());
    try {
      final workout = await repository.loadWorkout(event.workoutId);
      if (workout == null) {
        emit(WorkoutDetailError(message: 'Workout not found'));
        return;
      }

      final exerciseIds = workout.exercises.map((e) => e.exerciseId).toList();
      final exercisesMap = await repository.loadExercisesByIds(exerciseIds);

      emit(WorkoutDetailLoaded(workout: workout, exercises: exercisesMap));
    } catch (e) {
      emit(WorkoutDetailError(message: e.toString()));
    }
  }
}
