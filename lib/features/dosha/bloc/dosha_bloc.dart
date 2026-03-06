import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:beyou/features/dosha/models/assessment_option.dart';
import 'package:beyou/features/dosha/models/assessment_question.dart';
import 'package:beyou/features/dosha/models/assessment_result.dart';
import 'package:beyou/features/dosha/models/dosha_profiles.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

class DoshaBloc extends Bloc<DoshaEvent, DoshaState> {
  DoshaBloc({required this.repository}) : super(const DoshaOnboarding()) {
    on<DoshaStarted>(_onStarted);
    on<DoshaOptionSelected>(_onOptionSelected);
    on<DoshaNextPressed>(_onNext);
    on<DoshaPreviousPressed>(_onPrevious);
    on<DoshaRestarted>(_onRestart);
    on<DoshaHistoryLoaded>(_onHistoryLoaded);
    on<DoshaHistoryCleared>(_onHistoryCleared);
    on<DoshaHistoryResultTapped>(_onHistoryResultTapped);
    on<DoshaBackToHome>(_onBackToHome);
  }

  final DoshaRepository repository;

  void _onStarted(DoshaStarted event, Emitter<DoshaState> emit) {
    emit(DoshaAssessing(
      participantName: event.participantName,
      questions: QuestionBank.all(),
      currentIndex: 0,
      responses: const {},
    ));
  }

  void _onOptionSelected(DoshaOptionSelected event, Emitter<DoshaState> emit) {
    final current = state;
    if (current is! DoshaAssessing) return;

    final updated = Map<String, AssessmentOption>.from(current.responses);
    updated[current.currentQuestion.id] = event.option;
    emit(current.copyWith(responses: updated));
  }

  void _onNext(DoshaNextPressed event, Emitter<DoshaState> emit) async {
    final current = state;
    if (current is! DoshaAssessing) return;

    if (current.isOnLastQuestion) {
      if (!current.isComplete) return; // can't proceed without all answers
      // Calculate and navigate to results
      final scores = _normalizedScores(current.responses);
      final insights = _buildInsights(scores);

      // Persist result
      final result = AssessmentResult(
        participantName: current.participantName,
        timestamp: DateTime.now(),
        doshaPercentages: scores,
        primaryTraits: insights.traits,
        recommendations: insights.recommendations,
      );
      await repository.saveResult(result);

      emit(DoshaResults(
        participantName: current.participantName,
        doshaScores: scores,
        primaryTraits: insights.traits,
        recommendations: insights.recommendations,
      ));
      return;
    }

    final nextIndex = (current.currentIndex + 1).clamp(0, current.questionCount - 1);
    emit(current.copyWith(currentIndex: nextIndex));
  }

  void _onPrevious(DoshaPreviousPressed event, Emitter<DoshaState> emit) {
    final current = state;
    if (current is! DoshaAssessing) return;
    if (current.isOnFirstQuestion) return;

    final prevIndex = (current.currentIndex - 1).clamp(0, current.questionCount - 1);
    emit(current.copyWith(currentIndex: prevIndex));
  }

  void _onRestart(DoshaRestarted event, Emitter<DoshaState> emit) {
    emit(const DoshaOnboarding());
  }

  void _onBackToHome(DoshaBackToHome event, Emitter<DoshaState> emit) {
    emit(const DoshaOnboarding());
  }

  void _onHistoryLoaded(DoshaHistoryLoaded event, Emitter<DoshaState> emit) async {
    emit(const DoshaHistoryState(history: [], isLoading: true));
    final history = await repository.loadHistory();
    emit(DoshaHistoryState(history: history));
  }

  void _onHistoryCleared(DoshaHistoryCleared event, Emitter<DoshaState> emit) async {
    await repository.clearHistory();
    emit(const DoshaHistoryState(history: []));
  }

  void _onHistoryResultTapped(DoshaHistoryResultTapped event, Emitter<DoshaState> emit) {
    final r = event.result;
    emit(DoshaResults(
      participantName: r.participantName,
      doshaScores: Map<String, double>.from(r.doshaPercentages),
      primaryTraits: List<String>.from(r.primaryTraits),
      recommendations: List<String>.from(r.recommendations),
    ));
  }

  // ==========================================
  // Score helpers
  // ==========================================

  Map<String, double> _normalizedScores(Map<String, AssessmentOption> responses) {
    final totals = <DoshaType, double>{
      for (final dosha in DoshaType.values) dosha: 0,
    };

    for (final option in responses.values) {
      option.weights.forEach((dosha, weight) {
        totals[dosha] = (totals[dosha] ?? 0) + weight;
      });
    }

    final totalValue = totals.values.fold<double>(0, (sum, v) => sum + v);
    if (totalValue == 0) {
      return {for (final dosha in DoshaType.values) dosha.label: 0};
    }
    return {
      for (final entry in totals.entries)
        entry.key.label: (entry.value / totalValue * 100).clamp(0, 100).toDouble(),
    };
  }

  DoshaInsights _buildInsights(Map<String, double> normalized) {
    final sortedEntries = normalized.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final highest = sortedEntries[0];
    final second = sortedEntries[1];
    final third = sortedEntries[2];

    if ((highest.value - third.value).abs() <= 7) {
      return DoshaProfiles.tridoshic();
    } else if ((highest.value - second.value).abs() <= 10) {
      final primary = DoshaType.values.firstWhere((e) => e.label == highest.key);
      final secondary = DoshaType.values.firstWhere((e) => e.label == second.key);
      return DoshaProfiles.dual(primary, secondary);
    } else {
      final primary = DoshaType.values.firstWhere((e) => e.label == highest.key);
      return DoshaProfiles.single(primary);
    }
  }
}
