import 'package:beyou/features/dosha/models/dosha_type.dart';

enum ProgramCategory {
  anxietyStress,
  postnatal,
  panchakarma,
  selfTherapy,
}

extension ProgramCategoryX on ProgramCategory {
  String get label {
    switch (this) {
      case ProgramCategory.anxietyStress:
        return 'Anxiety & Stress';
      case ProgramCategory.postnatal:
        return 'Postnatal Care';
      case ProgramCategory.panchakarma:
        return 'Panchakarma';
      case ProgramCategory.selfTherapy:
        return 'Self-Therapy';
    }
  }

  String get emoji {
    switch (this) {
      case ProgramCategory.anxietyStress:
        return '🌿';
      case ProgramCategory.postnatal:
        return '🤱';
      case ProgramCategory.panchakarma:
        return '🪷';
      case ProgramCategory.selfTherapy:
        return '🧴';
    }
  }
}

class ProgramSession {
  final String title;
  final String description;
  final int durationMinutes;

  const ProgramSession({
    required this.title,
    required this.description,
    required this.durationMinutes,
  });
}

class AyurvedaProgram {
  final String id;
  final String title;
  final ProgramCategory category;
  final String description;
  final int durationDays;
  final List<DoshaType> doshas;
  final List<ProgramSession> sessions;
  final List<String> benefits;
  final String emoji;

  const AyurvedaProgram({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.durationDays,
    required this.doshas,
    required this.sessions,
    required this.benefits,
    required this.emoji,
  });
}
