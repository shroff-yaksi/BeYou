part of 'active_workout_bloc.dart';

@immutable
sealed class ActiveWorkoutEvent {}

class StartWorkoutSessionEvent extends ActiveWorkoutEvent {
  final Workout workout;
  final Map<String, Exercise> exercises;
  StartWorkoutSessionEvent({required this.workout, required this.exercises});
}

class CompleteSetEvent extends ActiveWorkoutEvent {
  final int reps;
  final double weightKg;
  CompleteSetEvent({required this.reps, required this.weightKg});
}

class SkipExerciseEvent extends ActiveWorkoutEvent {}

class UpdateTimerEvent extends ActiveWorkoutEvent {}

class StartRestTimerEvent extends ActiveWorkoutEvent {}

class FinishRestEvent extends ActiveWorkoutEvent {}

class CompleteWorkoutEvent extends ActiveWorkoutEvent {}
