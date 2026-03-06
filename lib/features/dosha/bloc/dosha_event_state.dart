import 'package:equatable/equatable.dart';
import 'package:beyou/features/dosha/models/assessment_option.dart';
import 'package:beyou/features/dosha/models/assessment_question.dart';
import 'package:beyou/features/dosha/models/assessment_result.dart';

// ==========================================
// Events
// ==========================================

abstract class DoshaEvent extends Equatable {
  const DoshaEvent();
  @override
  List<Object?> get props => [];
}

class DoshaStarted extends DoshaEvent {
  const DoshaStarted(this.participantName);
  final String participantName;
  @override
  List<Object?> get props => [participantName];
}

class DoshaOptionSelected extends DoshaEvent {
  const DoshaOptionSelected(this.option);
  final AssessmentOption option;
  @override
  List<Object?> get props => [option];
}

class DoshaNextPressed extends DoshaEvent {
  const DoshaNextPressed();
}

class DoshaPreviousPressed extends DoshaEvent {
  const DoshaPreviousPressed();
}

class DoshaRestarted extends DoshaEvent {
  const DoshaRestarted();
}

class DoshaHistoryLoaded extends DoshaEvent {
  const DoshaHistoryLoaded();
}

class DoshaHistoryCleared extends DoshaEvent {
  const DoshaHistoryCleared();
}

class DoshaHistoryResultTapped extends DoshaEvent {
  const DoshaHistoryResultTapped(this.result);
  final AssessmentResult result;
  @override
  List<Object?> get props => [result];
}

class DoshaBackToHome extends DoshaEvent {
  const DoshaBackToHome();
}

// ==========================================
// States
// ==========================================

abstract class DoshaState extends Equatable {
  const DoshaState();
  @override
  List<Object?> get props => [];
}

/// Landing screen — enter name to begin
class DoshaOnboarding extends DoshaState {
  const DoshaOnboarding();
}

/// Assessment in progress
class DoshaAssessing extends DoshaState {
  const DoshaAssessing({
    required this.participantName,
    required this.questions,
    required this.currentIndex,
    required this.responses,
  });

  final String participantName;
  final List<AssessmentQuestion> questions;
  final int currentIndex;
  final Map<String, AssessmentOption> responses;

  AssessmentQuestion get currentQuestion => questions[currentIndex];
  int get questionCount => questions.length;
  bool get isOnFirstQuestion => currentIndex == 0;
  bool get isOnLastQuestion => currentIndex == questionCount - 1;
  String get progressLabel => '${currentIndex + 1} / $questionCount';
  AssessmentOption? get selectedOption => responses[currentQuestion.id];
  bool get isComplete => responses.length == questions.length;
  double get progressValue => (currentIndex + 1) / questionCount;

  DoshaAssessing copyWith({
    int? currentIndex,
    Map<String, AssessmentOption>? responses,
  }) {
    return DoshaAssessing(
      participantName: participantName,
      questions: questions,
      currentIndex: currentIndex ?? this.currentIndex,
      responses: responses ?? this.responses,
    );
  }

  @override
  List<Object?> get props => [participantName, currentIndex, responses];
}

/// Results displayed
class DoshaResults extends DoshaState {
  const DoshaResults({
    required this.participantName,
    required this.doshaScores,
    required this.primaryTraits,
    required this.recommendations,
  });

  final String participantName;
  final Map<String, double> doshaScores;
  final List<String> primaryTraits;
  final List<String> recommendations;

  String get primaryDoshaLabel {
    final sorted = doshaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.isEmpty ? 'Unknown' : sorted.first.key;
  }

  List<MapEntry<String, double>> get sortedScores {
    return doshaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  }

  @override
  List<Object?> get props => [participantName, doshaScores, primaryTraits, recommendations];
}

/// History list
class DoshaHistoryState extends DoshaState {
  const DoshaHistoryState({
    required this.history,
    this.isLoading = false,
  });

  final List<AssessmentResult> history;
  final bool isLoading;

  @override
  List<Object?> get props => [history, isLoading];
}
