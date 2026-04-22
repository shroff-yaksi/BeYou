import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseSet {
  final int reps;
  final double weightKg;

  const ExerciseSet({required this.reps, required this.weightKg});

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      reps: (map['reps'] as num).toInt(),
      weightKg: (map['weightKg'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {'reps': reps, 'weightKg': weightKg};
}

class CompletedExercise {
  final String exerciseId;
  final String exerciseName;
  final List<ExerciseSet> sets;

  const CompletedExercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
  });

  factory CompletedExercise.fromMap(Map<String, dynamic> map) {
    return CompletedExercise(
      exerciseId: map['exerciseId'] as String,
      exerciseName: map['exerciseName'] as String,
      sets: (map['sets'] as List<dynamic>? ?? [])
          .map((s) => ExerciseSet.fromMap(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'exerciseId': exerciseId,
    'exerciseName': exerciseName,
    'sets': sets.map((s) => s.toMap()).toList(),
  };
}

class WorkoutSession {
  final String id;
  final String workoutId;
  final String workoutTitle;
  final String workoutCategory;
  final DateTime startedAt;
  final DateTime completedAt;
  final int durationSeconds;
  final int caloriesBurned;
  final List<CompletedExercise> exercisesCompleted;
  final String? notes;

  const WorkoutSession({
    required this.id,
    required this.workoutId,
    required this.workoutTitle,
    required this.workoutCategory,
    required this.startedAt,
    required this.completedAt,
    required this.durationSeconds,
    required this.caloriesBurned,
    required this.exercisesCompleted,
    this.notes,
  });

  factory WorkoutSession.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WorkoutSession(
      id: doc.id,
      workoutId: data['workoutId'] as String,
      workoutTitle: data['workoutTitle'] as String,
      workoutCategory: data['workoutCategory'] as String? ?? 'Fitness',
      startedAt: (data['startedAt'] as Timestamp).toDate(),
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      durationSeconds: (data['durationSeconds'] as num).toInt(),
      caloriesBurned: (data['caloriesBurned'] as num).toInt(),
      exercisesCompleted: (data['exercisesCompleted'] as List<dynamic>? ?? [])
          .map((e) => CompletedExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'workoutId': workoutId,
      'workoutTitle': workoutTitle,
      'workoutCategory': workoutCategory,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt': Timestamp.fromDate(completedAt),
      'durationSeconds': durationSeconds,
      'caloriesBurned': caloriesBurned,
      'exercisesCompleted': exercisesCompleted.map((e) => e.toMap()).toList(),
      if (notes != null) 'notes': notes,
    };
  }

  String get durationFormatted {
    final minutes = durationSeconds ~/ 60;
    if (minutes < 60) return '${minutes}m';
    return '${minutes ~/ 60}h ${minutes % 60}m';
  }

  String get dateFormatted {
    final now = DateTime.now();
    final diff = now.difference(completedAt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${completedAt.day}/${completedAt.month}/${completedAt.year}';
  }
}
