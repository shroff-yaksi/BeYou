part of 'metrics_bloc.dart';

@immutable
sealed class MetricsState {}

class MetricsInitial extends MetricsState {}

class MetricsLoading extends MetricsState {}

class MetricsLoaded extends MetricsState {
  final List<BodyMetric> metrics;
  final List<PersonalRecord> personalRecords;

  MetricsLoaded({required this.metrics, required this.personalRecords});

  BodyMetric? get latest => metrics.isEmpty ? null : metrics.first;

  // Last 30 weight entries (oldest → newest) for chart
  List<BodyMetric> get weightHistory {
    return metrics.where((m) => m.weightKg != null).take(30).toList().reversed.toList();
  }
}

class MetricsError extends MetricsState {
  final String message;
  MetricsError({required this.message});
}
