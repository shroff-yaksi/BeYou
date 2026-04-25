import 'package:flutter/material.dart';

enum MeditationCategory {
  guided,
  unguided,
  loving,
  body,
  breath,
  manifestation,
  morning,
  evening,
}

extension MeditationCategoryX on MeditationCategory {
  String get label {
    switch (this) {
      case MeditationCategory.guided:
        return 'Guided';
      case MeditationCategory.unguided:
        return 'Unguided';
      case MeditationCategory.loving:
        return 'Loving-Kindness';
      case MeditationCategory.body:
        return 'Body Scan';
      case MeditationCategory.breath:
        return 'Breath Awareness';
      case MeditationCategory.manifestation:
        return 'Manifestation';
      case MeditationCategory.morning:
        return 'Morning';
      case MeditationCategory.evening:
        return 'Evening';
    }
  }

  String get emoji {
    switch (this) {
      case MeditationCategory.guided:
        return '🧘';
      case MeditationCategory.unguided:
        return '🤍';
      case MeditationCategory.loving:
        return '💗';
      case MeditationCategory.body:
        return '🌿';
      case MeditationCategory.breath:
        return '🌬️';
      case MeditationCategory.manifestation:
        return '✨';
      case MeditationCategory.morning:
        return '🌅';
      case MeditationCategory.evening:
        return '🌙';
    }
  }
}

class MeditationSession {
  final String id;
  final String title;
  final String narrator;
  final MeditationCategory category;
  final int durationMinutes;
  final String description;
  final String emoji;
  final Color accentColor;
  final String? audioUrl;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.narrator,
    required this.category,
    required this.durationMinutes,
    required this.description,
    required this.emoji,
    required this.accentColor,
    this.audioUrl,
  });
}
