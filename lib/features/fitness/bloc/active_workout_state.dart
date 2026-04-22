part of 'active_workout_bloc.dart';

@immutable
sealed class ActiveWorkoutState {}

class ActiveWorkoutInitial extends ActiveWorkoutState {}

class ActiveWorkoutInProgress extends ActiveWorkoutState {
  final Workout workout;
  final Map<String, Exercise> exercises;
  final int currentExerciseIndex;
  final int currentSetIndex;
  final int elapsedSeconds;
  final Map<String, ExerciseSet> completedSets;
  final bool isResting;
  final int restSecondsRemaining;
  final DateTime startedAt;

  ActiveWorkoutInProgress({
    required this.workout,
    required this.exercises,
    required this.currentExerciseIndex,
    required this.currentSetIndex,
    required this.elapsedSeconds,
    required this.completedSets,
    required this.isResting,
    required this.restSecondsRemaining,
    required this.startedAt,
  });

  WorkoutExerciseRef get currentExerciseRef =>
      workout.exercises[currentExerciseIndex];

  Exercise? get currentExercise =>
      exercises[currentExerciseRef.exerciseId];

  WorkoutExerciseRef? get nextExerciseRef {
    final next = currentExerciseIndex + 1;
    return next < workout.exercises.length ? workout.exercises[next] : null;
  }

  String get elapsedFormatted {
    final m = elapsedSeconds ~/ 60;
    final s = elapsedSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get overallProgress {
    final total = workout.exercises.length;
    return total == 0 ? 0 : (currentExerciseIndex / total).clamp(0.0, 1.0);
  }

  ActiveWorkoutInProgress copyWith({
    Workout? workout,
    Map<String, Exercise>? exercises,
    int? currentExerciseIndex,
    int? currentSetIndex,
    int? elapsedSeconds,
    Map<String, ExerciseSet>? completedSets,
    bool? isResting,
    int? restSecondsRemaining,
    DateTime? startedAt,
  }) {
    return ActiveWorkoutInProgress(
      workout: workout ?? this.workout,
      exercises: exercises ?? this.exercises,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      currentSetIndex: currentSetIndex ?? this.currentSetIndex,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      completedSets: completedSets ?? this.completedSets,
      isResting: isResting ?? this.isResting,
      restSecondsRemaining: restSecondsRemaining ?? this.restSecondsRemaining,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}

class ActiveWorkoutCompleted extends ActiveWorkoutState {
  final WorkoutSession session;
  ActiveWorkoutCompleted({required this.session});
}
