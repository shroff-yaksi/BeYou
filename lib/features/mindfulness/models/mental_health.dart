enum AssessmentType { gad7, phq9, pss10 }

extension AssessmentTypeX on AssessmentType {
  String get label {
    switch (this) {
      case AssessmentType.gad7:
        return 'GAD-7 (Anxiety)';
      case AssessmentType.phq9:
        return 'PHQ-9 (Depression)';
      case AssessmentType.pss10:
        return 'PSS-10 (Stress)';
    }
  }

  String get description {
    switch (this) {
      case AssessmentType.gad7:
        return 'A validated 7-question screening for generalized anxiety over the past 2 weeks.';
      case AssessmentType.phq9:
        return 'A validated 9-question screening for depression over the past 2 weeks.';
      case AssessmentType.pss10:
        return 'A 10-question scale measuring perceived stress over the past month.';
    }
  }
}

class AssessmentQuestion {
  final String text;
  final List<String> options;
  final List<int> scores;

  const AssessmentQuestion({
    required this.text,
    required this.options,
    required this.scores,
  });
}

class AssessmentResult {
  final AssessmentType type;
  final int score;
  final String severity;
  final String guidance;

  const AssessmentResult({
    required this.type,
    required this.score,
    required this.severity,
    required this.guidance,
  });
}

class MentalHealthAssessment {
  final AssessmentType type;
  final List<AssessmentQuestion> questions;
  final List<({int min, int max, String severity, String guidance})> bands;

  const MentalHealthAssessment({
    required this.type,
    required this.questions,
    required this.bands,
  });

  AssessmentResult score(List<int> answers) {
    final total = answers.fold<int>(0, (sum, n) => sum + n);
    final band = bands.firstWhere(
      (b) => total >= b.min && total <= b.max,
      orElse: () => bands.last,
    );
    return AssessmentResult(
      type: type,
      score: total,
      severity: band.severity,
      guidance: band.guidance,
    );
  }
}

enum CBTCategory { cbt, dbt, grounding }

extension CBTCategoryX on CBTCategory {
  String get label {
    switch (this) {
      case CBTCategory.cbt:
        return 'CBT';
      case CBTCategory.dbt:
        return 'DBT';
      case CBTCategory.grounding:
        return 'Grounding';
    }
  }
}

class CBTExercise {
  final String id;
  final String title;
  final CBTCategory category;
  final int durationMinutes;
  final String description;
  final List<String> steps;
  final String emoji;

  const CBTExercise({
    required this.id,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.description,
    required this.steps,
    required this.emoji,
  });
}

enum CrisisResourceKind { helpline, chat, emergency, peer }

class CrisisResource {
  final String name;
  final String description;
  final String phone;
  final String? website;
  final String hours;
  final CrisisResourceKind kind;

  const CrisisResource({
    required this.name,
    required this.description,
    required this.phone,
    required this.hours,
    required this.kind,
    this.website,
  });
}
