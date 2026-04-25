enum SleepContentType { story, soundscape, music, meditation }

extension SleepContentTypeX on SleepContentType {
  String get label {
    switch (this) {
      case SleepContentType.story:
        return 'Sleep Story';
      case SleepContentType.soundscape:
        return 'Ambient Sound';
      case SleepContentType.music:
        return 'Sleep Music';
      case SleepContentType.meditation:
        return 'Sleep Meditation';
    }
  }

  String get emoji {
    switch (this) {
      case SleepContentType.story:
        return '📖';
      case SleepContentType.soundscape:
        return '🌧️';
      case SleepContentType.music:
        return '🎵';
      case SleepContentType.meditation:
        return '🌙';
    }
  }
}

class SleepContent {
  final String id;
  final String title;
  final SleepContentType type;
  final int durationMinutes;
  final String narrator;
  final String description;
  final String emoji;
  final String? audioUrl;
  final bool isLoopable;

  const SleepContent({
    required this.id,
    required this.title,
    required this.type,
    required this.durationMinutes,
    required this.narrator,
    required this.description,
    required this.emoji,
    this.audioUrl,
    this.isLoopable = false,
  });
}
