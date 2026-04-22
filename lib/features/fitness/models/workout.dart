import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutExerciseRef {
  final String exerciseId;
  final String exerciseName;
  final int sets;
  final int reps;
  final int restSeconds;
  final double? weightKg;
  final String? notes;

  const WorkoutExerciseRef({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.weightKg,
    this.notes,
  });

  factory WorkoutExerciseRef.fromMap(Map<String, dynamic> map) {
    return WorkoutExerciseRef(
      exerciseId: map['exerciseId'] as String,
      exerciseName: map['exerciseName'] as String,
      sets: (map['sets'] as num).toInt(),
      reps: (map['reps'] as num).toInt(),
      restSeconds: (map['restSeconds'] as num? ?? 60).toInt(),
      weightKg: (map['weightKg'] as num?)?.toDouble(),
      notes: map['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      if (weightKg != null) 'weightKg': weightKg,
      if (notes != null) 'notes': notes,
    };
  }

  WorkoutExerciseRef copyWith({
    String? exerciseId,
    String? exerciseName,
    int? sets,
    int? reps,
    int? restSeconds,
    double? weightKg,
    String? notes,
  }) {
    return WorkoutExerciseRef(
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
    );
  }
}

class Workout {
  final String id;
  final String title;
  final String category;
  final String level;
  final int durationMinutes;
  final int exerciseCount;
  final String imageAsset;
  final List<WorkoutExerciseRef> exercises;
  final List<String> tags;
  final bool isCustom;
  final String? createdBy;

  const Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.durationMinutes,
    required this.exerciseCount,
    required this.imageAsset,
    required this.exercises,
    required this.tags,
    this.isCustom = false,
    this.createdBy,
  });

  factory Workout.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Workout(
      id: doc.id,
      title: data['title'] as String,
      category: data['category'] as String,
      level: data['level'] as String,
      durationMinutes: (data['durationMinutes'] as num).toInt(),
      exerciseCount: (data['exerciseCount'] as num).toInt(),
      imageAsset: data['imageAsset'] as String? ?? 'assets/icons/workouts/full_body.png',
      exercises: (data['exercises'] as List<dynamic>? ?? [])
          .map((e) => WorkoutExerciseRef.fromMap(e as Map<String, dynamic>))
          .toList(),
      tags: (data['tags'] as List<dynamic>? ?? []).cast<String>(),
      isCustom: data['isCustom'] as bool? ?? false,
      createdBy: data['createdBy'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'category': category,
      'level': level,
      'durationMinutes': durationMinutes,
      'exerciseCount': exerciseCount,
      'imageAsset': imageAsset,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'tags': tags,
      'isCustom': isCustom,
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  Workout copyWith({
    String? id,
    String? title,
    String? category,
    String? level,
    int? durationMinutes,
    int? exerciseCount,
    String? imageAsset,
    List<WorkoutExerciseRef>? exercises,
    List<String>? tags,
    bool? isCustom,
    String? createdBy,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      level: level ?? this.level,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      imageAsset: imageAsset ?? this.imageAsset,
      exercises: exercises ?? this.exercises,
      tags: tags ?? this.tags,
      isCustom: isCustom ?? this.isCustom,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
