import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/body_metric.dart';
import 'package:beyou/features/fitness/models/personal_record.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'metrics_event.dart';
part 'metrics_state.dart';

class MetricsBloc extends Bloc<MetricsEvent, MetricsState> {
  final FitnessRepository repository;

  MetricsBloc({required this.repository}) : super(MetricsInitial()) {
    on<LoadMetricsEvent>(_onLoad);
    on<SaveBodyMetricEvent>(_onSave);
    on<DeleteBodyMetricEvent>(_onDelete);
  }

  Future<void> _onLoad(
      LoadMetricsEvent event, Emitter<MetricsState> emit) async {
    emit(MetricsLoading());
    try {
      final metrics = await repository.loadBodyMetrics();
      final prs = await repository.loadPersonalRecords();
      emit(MetricsLoaded(metrics: metrics, personalRecords: prs));
    } catch (e) {
      emit(MetricsError(message: e.toString()));
    }
  }

  Future<void> _onSave(
      SaveBodyMetricEvent event, Emitter<MetricsState> emit) async {
    final metric = BodyMetric(
      id: const Uuid().v4(),
      date: DateTime.now(),
      weightKg: event.weightKg,
      bodyFatPct: event.bodyFatPct,
      chest: event.chest,
      waist: event.waist,
      hips: event.hips,
      arms: event.arms,
      thighs: event.thighs,
    );
    try {
      await repository.saveBodyMetric(metric);
      add(LoadMetricsEvent());
    } catch (e) {
      emit(MetricsError(message: e.toString()));
    }
  }

  Future<void> _onDelete(
      DeleteBodyMetricEvent event, Emitter<MetricsState> emit) async {
    try {
      await repository.deleteBodyMetric(event.metricId);
      add(LoadMetricsEvent());
    } catch (e) {
      emit(MetricsError(message: e.toString()));
    }
  }
}
