part of 'progress_bloc.dart';

@immutable
sealed class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<WorkoutSession> sessions;
  final List<BodyMetric> metrics;

  ProgressLoaded({required this.sessions, required this.metrics});

  /// Workouts per week for the last 8 weeks (oldest → newest).
  List<int> get weeklyWorkoutCounts {
    final counts = List<int>.filled(8, 0);
    final now = DateTime.now();
    for (final session in sessions) {
      final daysAgo = now.difference(session.completedAt).inDays;
      final weekIndex = 7 - (daysAgo ~/ 7).clamp(0, 7);
      if (weekIndex >= 0 && weekIndex < 8) {
        counts[weekIndex]++;
      }
    }
    return counts;
  }

  /// Weight data for the last 30 days (oldest → newest).
  List<({DateTime date, double weight})> get weightTrend {
    return metrics
        .where((m) => m.weightKg != null)
        .take(30)
        .toList()
        .reversed
        .map((m) => (date: m.date, weight: m.weightKg!))
        .toList();
  }

  /// Total workouts this week.
  int get thisWeekCount {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final weekStart = DateTime(monday.year, monday.month, monday.day);
    return sessions.where((s) => s.completedAt.isAfter(weekStart)).length;
  }

  /// Total minutes trained this week.
  int get thisWeekMinutes {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final weekStart = DateTime(monday.year, monday.month, monday.day);
    return sessions
        .where((s) => s.completedAt.isAfter(weekStart))
        .fold(0, (sum, s) => sum + s.durationSeconds ~/ 60);
  }
}

class ProgressError extends ProgressState {
  final String message;
  ProgressError({required this.message});
}
