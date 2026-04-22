import 'package:beyou/features/dosha/models/dosha_type.dart';

enum PranayamaPattern {
  box,           // 4-4-4-4
  fourSevenEight, // 4-7-8
  wimHof,        // 30 breaths + hold
  kapalbhati,    // rapid exhales
  anulomVilom,   // alternate nostril
  bhramari,      // humming bee
  ujjayi,        // ocean breath
  breathOfFire,  // rapid rhythmic
}

class PhaseStep {
  final String label;  // 'Inhale', 'Hold', 'Exhale', 'Hold out'
  final int seconds;

  const PhaseStep({required this.label, required this.seconds});
}

class PranayamaTechnique {
  final String id;
  final String name;
  final String sanskritName;
  final PranayamaPattern pattern;
  final String description;
  final String instructions;
  final List<PhaseStep> phases;   // animation cycle steps
  final int cyclesPerSession;
  final List<DoshaType> doshas;
  final List<String> benefits;
  final String? caution;
  final String emoji;
  final String difficulty; // 'Beginner', 'Intermediate', 'Advanced'

  const PranayamaTechnique({
    required this.id,
    required this.name,
    required this.sanskritName,
    required this.pattern,
    required this.description,
    required this.instructions,
    required this.phases,
    required this.cyclesPerSession,
    required this.doshas,
    required this.benefits,
    required this.emoji,
    required this.difficulty,
    this.caution,
  });
}
