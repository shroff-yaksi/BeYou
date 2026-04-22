part of 'workout_detail_bloc.dart';

@immutable
sealed class WorkoutDetailState {}

class WorkoutDetailInitial extends WorkoutDetailState {}

class WorkoutDetailLoading extends WorkoutDetailState {}

class WorkoutDetailLoaded extends WorkoutDetailState {
  final Workout workout;
  final Map<String, Exercise> exercises;

  WorkoutDetailLoaded({required this.workout, required this.exercises});
}

class WorkoutDetailError extends WorkoutDetailState {
  final String message;
  WorkoutDetailError({required this.message});
}
