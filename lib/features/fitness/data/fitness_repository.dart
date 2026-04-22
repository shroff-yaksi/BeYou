import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beyou/features/fitness/data/fitness_seed_data.dart';
import 'package:beyou/features/fitness/models/body_metric.dart';
import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/personal_record.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:beyou/features/fitness/models/workout_session.dart';

/// Repository for all fitness data.
///
/// Data layout in Firestore:
///   workouts/{workoutId}
///   exercises/{exerciseId}
///   users/{uid}/workout_sessions/{sessionId}
///   users/{uid}/body_metrics/{metricId}
///   users/{uid}/personal_records/{exerciseId}
///   users/{uid}/custom_workouts/{workoutId}
class FitnessRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  FitnessRepository({
    FirebaseFirestore? db,
    FirebaseAuth? auth,
  })  : _db = db ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ── Convenience getters ────────────────────────────────────────────────────

  String get _uid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return uid;
  }

  CollectionReference get _workouts => _db.collection('workouts');
  CollectionReference get _exercises => _db.collection('exercises');
  CollectionReference get _sessions =>
      _db.collection('users').doc(_uid).collection('workout_sessions');
  CollectionReference get _bodyMetrics =>
      _db.collection('users').doc(_uid).collection('body_metrics');
  CollectionReference get _prs =>
      _db.collection('users').doc(_uid).collection('personal_records');
  CollectionReference get _customWorkouts =>
      _db.collection('users').doc(_uid).collection('custom_workouts');

  // ── Seeding ────────────────────────────────────────────────────────────────

  /// Seeds Firestore with built-in exercises and workout programs if they
  /// don't already exist.  Safe to call on every app launch — it checks first.
  Future<void> seedIfNeeded() async {
    try {
      final snap = await _workouts.limit(1).get();
      if (snap.docs.isNotEmpty) return; // already seeded

      final batch = _db.batch();

      for (final exercise in FitnessSeedData.exercises) {
        batch.set(
          _exercises.doc(exercise.id),
          exercise.toFirestore(),
        );
      }

      for (final workout in FitnessSeedData.workouts) {
        batch.set(
          _workouts.doc(workout.id),
          workout.toFirestore(),
        );
      }

      await batch.commit();
    } catch (_) {
      // Seeding failure must never crash the app; just continue with local
      // fallback data.
    }
  }

  // ── Workouts ───────────────────────────────────────────────────────────────

  /// Load all global workout programs, optionally filtered.
  Future<List<Workout>> loadWorkouts({
    String? category,
    String? level,
    String? searchQuery,
  }) async {
    try {
      Query query = _workouts.orderBy('title');

      if (category != null && category != 'All') {
        query = query.where('category', isEqualTo: category);
      }
      if (level != null && level != 'All') {
        query = query.where('level', isEqualTo: level);
      }

      final snap = await query.get();
      var workouts = snap.docs.map(Workout.fromFirestore).toList();

      // Load user's custom workouts
      final customSnap = await _customWorkouts.get();
      workouts.addAll(customSnap.docs.map(Workout.fromFirestore));

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        workouts = workouts
            .where((w) =>
                w.title.toLowerCase().contains(q) ||
                w.category.toLowerCase().contains(q) ||
                w.tags.any((t) => t.toLowerCase().contains(q)))
            .toList();
      }

      return workouts;
    } catch (_) {
      // Fallback to seed data when Firestore is unavailable
      return FitnessSeedData.workouts;
    }
  }

  /// Load a single workout by ID (checks global then custom).
  Future<Workout?> loadWorkout(String id) async {
    try {
      DocumentSnapshot doc = await _workouts.doc(id).get();
      if (!doc.exists) {
        doc = await _customWorkouts.doc(id).get();
      }
      if (!doc.exists) return null;
      return Workout.fromFirestore(doc);
    } catch (_) {
      return FitnessSeedData.workouts
          .where((w) => w.id == id)
          .firstOrNull;
    }
  }

  // ── Exercises ──────────────────────────────────────────────────────────────

  /// Load exercises by IDs (used when building workout detail view).
  Future<Map<String, Exercise>> loadExercisesByIds(List<String> ids) async {
    if (ids.isEmpty) return {};
    try {
      final snaps = await Future.wait(
        ids.map((id) => _exercises.doc(id).get()),
      );
      final result = <String, Exercise>{};
      for (final doc in snaps) {
        if (doc.exists) {
          result[doc.id] = Exercise.fromFirestore(doc);
        }
      }
      return result;
    } catch (_) {
      final result = <String, Exercise>{};
      for (final exercise in FitnessSeedData.exercises) {
        if (ids.contains(exercise.id)) {
          result[exercise.id] = exercise;
        }
      }
      return result;
    }
  }

  /// Search exercises by name or muscle group.
  Future<List<Exercise>> searchExercises(String query) async {
    try {
      final snap = await _exercises.orderBy('name').get();
      final all = snap.docs.map((doc) => Exercise.fromFirestore(doc)).toList();
      if (query.isEmpty) return all;
      final q = query.toLowerCase();
      return all
          .where((e) =>
              e.name.toLowerCase().contains(q) ||
              e.muscleGroups.any((m) => m.toLowerCase().contains(q)) ||
              e.category.toLowerCase().contains(q))
          .toList();
    } catch (_) {
      final q = query.toLowerCase();
      return FitnessSeedData.exercises
          .where((e) =>
              e.name.toLowerCase().contains(q) ||
              e.muscleGroups.any((m) => m.toLowerCase().contains(q)))
          .toList();
    }
  }

  // ── Workout Sessions ───────────────────────────────────────────────────────

  /// Save a completed workout session and update any PRs.
  Future<void> saveWorkoutSession(WorkoutSession session) async {
    await _sessions.doc(session.id).set(session.toFirestore());
    await _updatePersonalRecords(session.exercisesCompleted);
  }

  /// Load all past workout sessions for the current user, newest first.
  Future<List<WorkoutSession>> loadWorkoutHistory({int limit = 50}) async {
    final snap = await _sessions
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .get();
    return snap.docs.map(WorkoutSession.fromFirestore).toList();
  }

  /// Load sessions completed this week (Mon–Sun).
  Future<List<WorkoutSession>> loadWeekSessions() async {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final weekStart = DateTime(monday.year, monday.month, monday.day);

    final snap = await _sessions
        .where('completedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(weekStart))
        .orderBy('completedAt', descending: true)
        .get();

    return snap.docs.map(WorkoutSession.fromFirestore).toList();
  }

  // ── Body Metrics ───────────────────────────────────────────────────────────

  /// Save a body metric entry.
  Future<void> saveBodyMetric(BodyMetric metric) async {
    await _bodyMetrics.doc(metric.id).set(metric.toFirestore());
  }

  /// Delete a body metric entry.
  Future<void> deleteBodyMetric(String id) async {
    await _bodyMetrics.doc(id).delete();
  }

  /// Load all body metrics, newest first.
  Future<List<BodyMetric>> loadBodyMetrics({int limit = 90}) async {
    final snap = await _bodyMetrics
        .orderBy('date', descending: true)
        .limit(limit)
        .get();
    return snap.docs.map(BodyMetric.fromFirestore).toList();
  }

  // ── Personal Records ───────────────────────────────────────────────────────

  /// Load all personal records for the current user.
  Future<List<PersonalRecord>> loadPersonalRecords() async {
    final snap = await _prs.orderBy('exerciseName').get();
    return snap.docs.map(PersonalRecord.fromFirestore).toList();
  }

  // ── Custom Workouts ────────────────────────────────────────────────────────

  /// Save a custom workout built by the user.
  Future<void> saveCustomWorkout(Workout workout) async {
    await _customWorkouts.doc(workout.id).set(workout.toFirestore());
  }

  /// Delete a custom workout.
  Future<void> deleteCustomWorkout(String id) async {
    await _customWorkouts.doc(id).delete();
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<void> _updatePersonalRecords(
      List<CompletedExercise> completed) async {
    for (final exercise in completed) {
      if (exercise.sets.isEmpty) continue;

      // best set = highest 1RM estimate (weight × (1 + reps / 30))
      final bestSet = exercise.sets.reduce((a, b) {
        final aScore = a.weightKg * (1 + a.reps / 30);
        final bScore = b.weightKg * (1 + b.reps / 30);
        return aScore >= bScore ? a : b;
      });

      final prDoc = await _prs.doc(exercise.exerciseId).get();
      if (!prDoc.exists) {
        await _prs.doc(exercise.exerciseId).set(
              PersonalRecord(
                exerciseId: exercise.exerciseId,
                exerciseName: exercise.exerciseName,
                bestWeightKg: bestSet.weightKg,
                bestReps: bestSet.reps,
                achievedAt: DateTime.now(),
              ).toFirestore(),
            );
      } else {
        final existing = PersonalRecord.fromFirestore(prDoc);
        final existingScore =
            existing.bestWeightKg * (1 + existing.bestReps / 30);
        final newScore = bestSet.weightKg * (1 + bestSet.reps / 30);

        if (newScore > existingScore) {
          await _prs.doc(exercise.exerciseId).set(
                PersonalRecord(
                  exerciseId: exercise.exerciseId,
                  exerciseName: exercise.exerciseName,
                  bestWeightKg: bestSet.weightKg,
                  bestReps: bestSet.reps,
                  achievedAt: DateTime.now(),
                ).toFirestore(),
              );
        }
      }
    }
  }
}
