import 'package:beyou/features/dosha/models/dosha_type.dart';

enum YogaStyle {
  hatha,
  vinyasa,
  ashtanga,
  kundalini,
  yin,
  restorative,
  prenatal,
  postnatal,
}

extension YogaStyleX on YogaStyle {
  String get label {
    switch (this) {
      case YogaStyle.hatha:
        return 'Hatha';
      case YogaStyle.vinyasa:
        return 'Vinyasa';
      case YogaStyle.ashtanga:
        return 'Ashtanga';
      case YogaStyle.kundalini:
        return 'Kundalini';
      case YogaStyle.yin:
        return 'Yin';
      case YogaStyle.restorative:
        return 'Restorative';
      case YogaStyle.prenatal:
        return 'Prenatal';
      case YogaStyle.postnatal:
        return 'Postnatal';
    }
  }
}

enum YogaLevel { beginner, intermediate, advanced }

extension YogaLevelX on YogaLevel {
  String get label {
    switch (this) {
      case YogaLevel.beginner:
        return 'Beginner';
      case YogaLevel.intermediate:
        return 'Intermediate';
      case YogaLevel.advanced:
        return 'Advanced';
    }
  }
}

class YogaSession {
  final String id;
  final String title;
  final YogaStyle style;
  final YogaLevel level;
  final int durationMinutes;
  final List<DoshaType> doshas;
  final String description;
  final List<String> benefits;
  final String? videoUrl;
  final String emoji;

  const YogaSession({
    required this.id,
    required this.title,
    required this.style,
    required this.level,
    required this.durationMinutes,
    required this.doshas,
    required this.description,
    required this.benefits,
    required this.emoji,
    this.videoUrl,
  });
}
