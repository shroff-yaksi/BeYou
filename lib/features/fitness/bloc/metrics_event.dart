part of 'metrics_bloc.dart';

@immutable
sealed class MetricsEvent {}

class LoadMetricsEvent extends MetricsEvent {}

class SaveBodyMetricEvent extends MetricsEvent {
  final double? weightKg;
  final double? bodyFatPct;
  final double? chest;
  final double? waist;
  final double? hips;
  final double? arms;
  final double? thighs;

  SaveBodyMetricEvent({
    this.weightKg,
    this.bodyFatPct,
    this.chest,
    this.waist,
    this.hips,
    this.arms,
    this.thighs,
  });
}

class DeleteBodyMetricEvent extends MetricsEvent {
  final String metricId;
  DeleteBodyMetricEvent({required this.metricId});
}
