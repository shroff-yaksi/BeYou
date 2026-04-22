import 'package:beyou/features/dosha/models/dosha_type.dart';

enum RemedyCategory {
  immunity,
  digestion,
  coldCough,
  skin,
  hair,
  sleep,
  stress,
  pain,
  womensHealth,
  mensHealth,
  weightManagement,
}

extension RemedyCategoryX on RemedyCategory {
  String get label {
    switch (this) {
      case RemedyCategory.immunity:
        return 'Immunity';
      case RemedyCategory.digestion:
        return 'Digestion';
      case RemedyCategory.coldCough:
        return 'Cold & Cough';
      case RemedyCategory.skin:
        return 'Skin';
      case RemedyCategory.hair:
        return 'Hair';
      case RemedyCategory.sleep:
        return 'Sleep';
      case RemedyCategory.stress:
        return 'Stress';
      case RemedyCategory.pain:
        return 'Pain Relief';
      case RemedyCategory.womensHealth:
        return "Women's Health";
      case RemedyCategory.mensHealth:
        return "Men's Health";
      case RemedyCategory.weightManagement:
        return 'Weight';
    }
  }

  String get emoji {
    switch (this) {
      case RemedyCategory.immunity:
        return '🛡️';
      case RemedyCategory.digestion:
        return '🫁';
      case RemedyCategory.coldCough:
        return '🤧';
      case RemedyCategory.skin:
        return '✨';
      case RemedyCategory.hair:
        return '💆';
      case RemedyCategory.sleep:
        return '😴';
      case RemedyCategory.stress:
        return '🧘';
      case RemedyCategory.pain:
        return '💊';
      case RemedyCategory.womensHealth:
        return '🌸';
      case RemedyCategory.mensHealth:
        return '💪';
      case RemedyCategory.weightManagement:
        return '⚖️';
    }
  }
}

class HomeRemedy {
  final String id;
  final String title;
  final RemedyCategory category;
  final List<DoshaType> doshas;
  final List<String> ingredients;
  final String preparation;
  final String usage;
  final List<String> benefits;
  final String? caution;

  const HomeRemedy({
    required this.id,
    required this.title,
    required this.category,
    required this.doshas,
    required this.ingredients,
    required this.preparation,
    required this.usage,
    required this.benefits,
    this.caution,
  });
}
