enum SosTechnique { breath, grounding, pmr, visualization }

extension SosTechniqueX on SosTechnique {
  String get label {
    switch (this) {
      case SosTechnique.breath:
        return 'Calm Breath';
      case SosTechnique.grounding:
        return '5-4-3-2-1 Grounding';
      case SosTechnique.pmr:
        return 'Progressive Muscle Relaxation';
      case SosTechnique.visualization:
        return 'Safe Place Visualization';
    }
  }

  String get emoji {
    switch (this) {
      case SosTechnique.breath:
        return '🌬️';
      case SosTechnique.grounding:
        return '🌍';
      case SosTechnique.pmr:
        return '💆';
      case SosTechnique.visualization:
        return '🏞️';
    }
  }
}

class SosSession {
  final String id;
  final String title;
  final SosTechnique technique;
  final int durationMinutes;
  final String description;
  final List<String> steps;

  const SosSession({
    required this.id,
    required this.title,
    required this.technique,
    required this.durationMinutes,
    required this.description,
    required this.steps,
  });
}
