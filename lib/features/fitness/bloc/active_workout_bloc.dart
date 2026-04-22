import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:beyou/features/fitness/models/workout_session.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'active_workout_event.dart';
part 'active_workout_state.dart';

class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  final FitnessRepository repository;

  ActiveWorkoutBloc({required this.repository}) : super(ActiveWorkoutInitial()) {
    on<StartWorkoutSessionEvent>(_onStart);
    on<CompleteSetEvent>(_onCompleteSet);
    on<SkipExerciseEvent>(_onSkipExercise);
    on<UpdateTimerEvent>(_onUpdateTimer);
    on<StartRestTimerEvent>(_onStartRest);
    on<FinishRestEvent>(_onFinishRest);
    on<CompleteWorkoutEvent>(_onCompleteWorkout);
  }

  Timer? _timer;
  Timer? _restTimer;

  @override
  Future<void> close() {
    _timer?.cancel();
    _restTimer?.cancel();
    return super.close();
  }

  void _onStart(
      StartWorkoutSessionEvent event, Emitter<ActiveWorkoutState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(UpdateTimerEvent());
    });

    emit(ActiveWorkoutInProgress(
      workout: event.workout,
      exercises: event.exercises,
      currentExerciseIndex: 0,
      currentSetIndex: 0,
      elapsedSeconds: 0,
      completedSets: {},
      isResting: false,
      restSecondsRemaining: 0,
      startedAt: DateTime.now(),
    ));
  }

  void _onUpdateTimer(
      UpdateTimerEvent event, Emitter<ActiveWorkoutState> emit) {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;
    emit(s.copyWith(elapsedSeconds: s.elapsedSeconds + 1));
  }

  void _onCompleteSet(
      CompleteSetEvent event, Emitter<ActiveWorkoutState> emit) {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;

    final exerciseRef = s.workout.exercises[s.currentExerciseIndex];
    final key = '${s.currentExerciseIndex}_${s.currentSetIndex}';

    final updatedSets = Map<String, ExerciseSet>.from(s.completedSets);
    updatedSets[key] = ExerciseSet(
      reps: event.reps,
      weightKg: event.weightKg,
    );

    final isLastSet = s.currentSetIndex >= exerciseRef.sets - 1;
    final isLastExercise =
        s.currentExerciseIndex >= s.workout.exercises.length - 1;

    if (isLastSet && isLastExercise) {
      // Last set of last exercise — go to rest, then finish
      emit(s.copyWith(
        completedSets: updatedSets,
        isResting: true,
        restSecondsRemaining: exerciseRef.restSeconds,
      ));
      _startRestCountdown(exerciseRef.restSeconds);
    } else if (isLastSet) {
      // Move to next exercise after rest
      _restTimer?.cancel();
      _restTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => add(StartRestTimerEvent()));
      emit(s.copyWith(
        completedSets: updatedSets,
        isResting: true,
        restSecondsRemaining: exerciseRef.restSeconds,
      ));
    } else {
      // More sets remaining
      emit(s.copyWith(
        completedSets: updatedSets,
        currentSetIndex: s.currentSetIndex + 1,
        isResting: true,
        restSecondsRemaining: exerciseRef.restSeconds,
      ));
      _startRestCountdown(exerciseRef.restSeconds);
    }
  }

  void _startRestCountdown(int seconds) {
    _restTimer?.cancel();
    _restTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => add(StartRestTimerEvent()));
  }

  void _onStartRest(
      StartRestTimerEvent event, Emitter<ActiveWorkoutState> emit) {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;

    if (s.restSecondsRemaining <= 1) {
      _restTimer?.cancel();
      add(FinishRestEvent());
    } else {
      emit(s.copyWith(restSecondsRemaining: s.restSecondsRemaining - 1));
    }
  }

  void _onFinishRest(
      FinishRestEvent event, Emitter<ActiveWorkoutState> emit) {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;

    final exerciseRef = s.workout.exercises[s.currentExerciseIndex];
    final isLastSet = s.currentSetIndex >= exerciseRef.sets - 1;

    if (isLastSet) {
      // Move to next exercise
      final nextExerciseIndex = s.currentExerciseIndex + 1;
      if (nextExerciseIndex >= s.workout.exercises.length) {
        add(CompleteWorkoutEvent());
        return;
      }
      emit(s.copyWith(
        currentExerciseIndex: nextExerciseIndex,
        currentSetIndex: 0,
        isResting: false,
        restSecondsRemaining: 0,
      ));
    } else {
      emit(s.copyWith(
        isResting: false,
        restSecondsRemaining: 0,
      ));
    }
  }

  void _onSkipExercise(
      SkipExerciseEvent event, Emitter<ActiveWorkoutState> emit) {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;
    _restTimer?.cancel();

    final nextIndex = s.currentExerciseIndex + 1;
    if (nextIndex >= s.workout.exercises.length) {
      add(CompleteWorkoutEvent());
      return;
    }
    emit(s.copyWith(
      currentExerciseIndex: nextIndex,
      currentSetIndex: 0,
      isResting: false,
      restSecondsRemaining: 0,
    ));
  }

  Future<void> _onCompleteWorkout(
      CompleteWorkoutEvent event, Emitter<ActiveWorkoutState> emit) async {
    final s = state;
    if (s is! ActiveWorkoutInProgress) return;

    _timer?.cancel();
    _restTimer?.cancel();

    // Build completed exercises from recorded sets
    final completed = <CompletedExercise>[];
    for (int i = 0; i < s.workout.exercises.length; i++) {
      final ref = s.workout.exercises[i];
      final sets = <ExerciseSet>[];
      for (int j = 0; j < ref.sets; j++) {
        final key = '${i}_$j';
        final set = s.completedSets[key];
        if (set != null) sets.add(set);
      }
      if (sets.isNotEmpty) {
        completed.add(CompletedExercise(
          exerciseId: ref.exerciseId,
          exerciseName: ref.exerciseName,
          sets: sets,
        ));
      }
    }

    // Estimate calories (~5 cal/min as a rough average)
    final durationMinutes = s.elapsedSeconds ~/ 60;
    final calories = (durationMinutes * 5).clamp(1, 9999);

    final session = WorkoutSession(
      id: const Uuid().v4(),
      workoutId: s.workout.id,
      workoutTitle: s.workout.title,
      workoutCategory: s.workout.category,
      startedAt: s.startedAt,
      completedAt: DateTime.now(),
      durationSeconds: s.elapsedSeconds,
      caloriesBurned: calories,
      exercisesCompleted: completed,
    );

    try {
      await repository.saveWorkoutSession(session);
    } catch (_) {
      // Non-fatal: show completion screen even if save fails
    }

    emit(ActiveWorkoutCompleted(session: session));
  }
}
