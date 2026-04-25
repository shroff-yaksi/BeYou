import 'package:flutter/material.dart';

enum AddictionType {
  smoking,
  alcohol,
  substances,
  gambling,
  socialMedia,
  gaming,
  porn,
  food,
  shopping,
  workaholism,
}

extension AddictionTypeX on AddictionType {
  String get label {
    switch (this) {
      case AddictionType.smoking:
        return 'Smoking';
      case AddictionType.alcohol:
        return 'Alcohol';
      case AddictionType.substances:
        return 'Substances';
      case AddictionType.gambling:
        return 'Gambling';
      case AddictionType.socialMedia:
        return 'Social Media';
      case AddictionType.gaming:
        return 'Gaming';
      case AddictionType.porn:
        return 'Pornography';
      case AddictionType.food:
        return 'Compulsive Eating';
      case AddictionType.shopping:
        return 'Shopping';
      case AddictionType.workaholism:
        return 'Workaholism';
    }
  }

  String get emoji {
    switch (this) {
      case AddictionType.smoking:
        return '🚭';
      case AddictionType.alcohol:
        return '🍺';
      case AddictionType.substances:
        return '💊';
      case AddictionType.gambling:
        return '🎲';
      case AddictionType.socialMedia:
        return '📱';
      case AddictionType.gaming:
        return '🎮';
      case AddictionType.porn:
        return '🔞';
      case AddictionType.food:
        return '🍔';
      case AddictionType.shopping:
        return '🛍️';
      case AddictionType.workaholism:
        return '💼';
    }
  }

  Color get color {
    switch (this) {
      case AddictionType.smoking:
        return const Color(0xFF8E8E93);
      case AddictionType.alcohol:
        return const Color(0xFFD4A017);
      case AddictionType.substances:
        return const Color(0xFFE74C3C);
      case AddictionType.gambling:
        return const Color(0xFF8E44AD);
      case AddictionType.socialMedia:
        return const Color(0xFF3498DB);
      case AddictionType.gaming:
        return const Color(0xFF6358E1);
      case AddictionType.porn:
        return const Color(0xFFE67E22);
      case AddictionType.food:
        return const Color(0xFFF39C12);
      case AddictionType.shopping:
        return const Color(0xFFE91E63);
      case AddictionType.workaholism:
        return const Color(0xFF34495E);
    }
  }

  /// Estimated daily cost in INR (used for "money saved" calculation).
  /// Conservative defaults; user can override later.
  int get defaultDailyCostINR {
    switch (this) {
      case AddictionType.smoking:
        return 200; // ~10 cigs @ ₹20
      case AddictionType.alcohol:
        return 500;
      case AddictionType.substances:
        return 1000;
      case AddictionType.gambling:
        return 800;
      case AddictionType.socialMedia:
        return 0;
      case AddictionType.gaming:
        return 100;
      case AddictionType.porn:
        return 0;
      case AddictionType.food:
        return 300;
      case AddictionType.shopping:
        return 700;
      case AddictionType.workaholism:
        return 0;
    }
  }
}

/// Health milestones unlocked at certain durations of abstinence.
class HealthMilestone {
  final String label;
  final String description;
  final Duration after;

  const HealthMilestone({
    required this.label,
    required this.description,
    required this.after,
  });
}

const kSmokingMilestones = <HealthMilestone>[
  HealthMilestone(
    label: '20 minutes',
    description: 'Heart rate and blood pressure drop to normal levels.',
    after: Duration(minutes: 20),
  ),
  HealthMilestone(
    label: '12 hours',
    description: 'Carbon monoxide in blood drops to normal.',
    after: Duration(hours: 12),
  ),
  HealthMilestone(
    label: '2 weeks',
    description: 'Circulation improves; lung function increases.',
    after: Duration(days: 14),
  ),
  HealthMilestone(
    label: '1 month',
    description: 'Coughing and shortness of breath decrease.',
    after: Duration(days: 30),
  ),
  HealthMilestone(
    label: '1 year',
    description: 'Risk of heart disease drops to half that of a smoker.',
    after: Duration(days: 365),
  ),
  HealthMilestone(
    label: '5 years',
    description: 'Stroke risk reduced to that of a non-smoker.',
    after: Duration(days: 1825),
  ),
];

const kGenericMilestones = <HealthMilestone>[
  HealthMilestone(
    label: '24 hours',
    description: 'You broke the first cycle. Acute cravings begin to fade.',
    after: Duration(hours: 24),
  ),
  HealthMilestone(
    label: '3 days',
    description: 'Mental clarity improves; sleep starts to normalize.',
    after: Duration(days: 3),
  ),
  HealthMilestone(
    label: '1 week',
    description: 'Mood stabilizes; energy levels return.',
    after: Duration(days: 7),
  ),
  HealthMilestone(
    label: '1 month',
    description: 'New neural pathways form; the urge weakens.',
    after: Duration(days: 30),
  ),
  HealthMilestone(
    label: '90 days',
    description: 'A new identity solidifies. The hardest phase is over.',
    after: Duration(days: 90),
  ),
  HealthMilestone(
    label: '1 year',
    description: 'You are a different person. Celebrate the journey.',
    after: Duration(days: 365),
  ),
];

class AddictionTracker {
  final AddictionType type;
  final DateTime cleanSince;
  final int dailyCostINR;
  final int relapseCount;

  const AddictionTracker({
    required this.type,
    required this.cleanSince,
    required this.dailyCostINR,
    this.relapseCount = 0,
  });

  Duration get cleanDuration => DateTime.now().difference(cleanSince);

  int get cleanDays => cleanDuration.inDays;

  int get moneySavedINR {
    final days = cleanDuration.inSeconds / 86400.0;
    return (days * dailyCostINR).round();
  }

  List<HealthMilestone> get milestones {
    return type == AddictionType.smoking ? kSmokingMilestones : kGenericMilestones;
  }

  HealthMilestone? get nextMilestone {
    final elapsed = cleanDuration;
    for (final m in milestones) {
      if (elapsed < m.after) return m;
    }
    return null;
  }

  AddictionTracker resetRelapse(DateTime newCleanSince) => AddictionTracker(
        type: type,
        cleanSince: newCleanSince,
        dailyCostINR: dailyCostINR,
        relapseCount: relapseCount + 1,
      );

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'cleanSince': cleanSince.toIso8601String(),
        'dailyCostINR': dailyCostINR,
        'relapseCount': relapseCount,
      };

  factory AddictionTracker.fromJson(Map<dynamic, dynamic> json) => AddictionTracker(
        type: AddictionType.values[json['type'] as int],
        cleanSince: DateTime.parse(json['cleanSince'] as String),
        dailyCostINR: json['dailyCostINR'] as int,
        relapseCount: json['relapseCount'] as int? ?? 0,
      );
}
