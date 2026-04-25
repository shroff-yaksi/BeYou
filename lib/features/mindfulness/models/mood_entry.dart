import 'package:flutter/material.dart';

enum MoodLevel { awful, bad, okay, good, great }

extension MoodLevelX on MoodLevel {
  String get label {
    switch (this) {
      case MoodLevel.awful:
        return 'Awful';
      case MoodLevel.bad:
        return 'Bad';
      case MoodLevel.okay:
        return 'Okay';
      case MoodLevel.good:
        return 'Good';
      case MoodLevel.great:
        return 'Great';
    }
  }

  String get emoji {
    switch (this) {
      case MoodLevel.awful:
        return '😩';
      case MoodLevel.bad:
        return '😟';
      case MoodLevel.okay:
        return '😐';
      case MoodLevel.good:
        return '🙂';
      case MoodLevel.great:
        return '😄';
    }
  }

  Color get color {
    switch (this) {
      case MoodLevel.awful:
        return const Color(0xFFE74C3C);
      case MoodLevel.bad:
        return const Color(0xFFE67E22);
      case MoodLevel.okay:
        return const Color(0xFFF1C40F);
      case MoodLevel.good:
        return const Color(0xFF52C78A);
      case MoodLevel.great:
        return const Color(0xFF27AE60);
    }
  }

  int get score => index + 1;
}

const kEmotionWheel = <String>[
  'Happy', 'Calm', 'Grateful', 'Hopeful', 'Energetic', 'Loved',
  'Anxious', 'Sad', 'Angry', 'Frustrated', 'Tired', 'Lonely',
  'Stressed', 'Bored', 'Confused', 'Jealous', 'Guilty', 'Excited',
];

class MoodEntry {
  final String id;
  final DateTime timestamp;
  final MoodLevel mood;
  final List<String> emotions;
  final String? gratitude;
  final String? note;

  const MoodEntry({
    required this.id,
    required this.timestamp,
    required this.mood,
    required this.emotions,
    this.gratitude,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': timestamp.toIso8601String(),
        'mood': mood.index,
        'emotions': emotions,
        'gratitude': gratitude,
        'note': note,
      };

  factory MoodEntry.fromJson(Map<dynamic, dynamic> json) => MoodEntry(
        id: json['id'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        mood: MoodLevel.values[json['mood'] as int],
        emotions: List<String>.from(json['emotions'] as List),
        gratitude: json['gratitude'] as String?,
        note: json['note'] as String?,
      );
}
