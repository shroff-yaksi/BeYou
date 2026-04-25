enum FocusPreset { classic, long, short, custom }

extension FocusPresetX on FocusPreset {
  String get label {
    switch (this) {
      case FocusPreset.classic:
        return 'Classic';
      case FocusPreset.long:
        return 'Deep Work';
      case FocusPreset.short:
        return 'Short Burst';
      case FocusPreset.custom:
        return 'Custom';
    }
  }

  int get focusMinutes {
    switch (this) {
      case FocusPreset.classic:
        return 25;
      case FocusPreset.long:
        return 50;
      case FocusPreset.short:
        return 15;
      case FocusPreset.custom:
        return 25;
    }
  }

  int get breakMinutes {
    switch (this) {
      case FocusPreset.classic:
        return 5;
      case FocusPreset.long:
        return 10;
      case FocusPreset.short:
        return 3;
      case FocusPreset.custom:
        return 5;
    }
  }
}

class FocusSession {
  final String id;
  final DateTime startedAt;
  final int focusMinutes;
  final int completedPomodoros;
  final String? task;

  const FocusSession({
    required this.id,
    required this.startedAt,
    required this.focusMinutes,
    required this.completedPomodoros,
    this.task,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'startedAt': startedAt.toIso8601String(),
        'focusMinutes': focusMinutes,
        'completedPomodoros': completedPomodoros,
        'task': task,
      };

  factory FocusSession.fromJson(Map<dynamic, dynamic> json) => FocusSession(
        id: json['id'] as String,
        startedAt: DateTime.parse(json['startedAt'] as String),
        focusMinutes: json['focusMinutes'] as int,
        completedPomodoros: json['completedPomodoros'] as int,
        task: json['task'] as String?,
      );
}
