import 'package:bloc/bloc.dart';
import 'package:beyou/data/exercise_data.dart';
import 'package:beyou/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workoutdetails_event.dart';
part 'workoutdetails_state.dart';

class WorkoutDetailsBloc extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  final WorkoutData workout;

  WorkoutDetailsBloc({required this.workout}) : super(WorkoutDetailsInitial()) {
    on<BackTappedEvent>(_onBackTapped);
    on<WorkoutExerciseCellTappedEvent>(_onExerciseCellTapped);
  }

  void _onBackTapped(BackTappedEvent event, Emitter<WorkoutDetailsState> emit) {
    emit(BackTappedState());
  }

  void _onExerciseCellTapped(
    WorkoutExerciseCellTappedEvent event,
    Emitter<WorkoutDetailsState> emit,
  ) {
    emit(WorkoutExerciseCellTappedState(
      currentExercise: event.currentExercise,
      nextExercise: event.nextExercise,
    ));
  }
}
