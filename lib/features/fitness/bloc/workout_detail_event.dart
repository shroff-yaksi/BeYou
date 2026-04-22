part of 'workout_detail_bloc.dart';

@immutable
sealed class WorkoutDetailEvent {}

class LoadWorkoutDetailEvent extends WorkoutDetailEvent {
  final String workoutId;
  LoadWorkoutDetailEvent({required this.workoutId});
}
