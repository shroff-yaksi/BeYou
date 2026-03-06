class ExerciseData {
  final String title;
  final int minutes;
  final double progress;
  final String video;
  final String description;
  final List<String> steps;

  ExerciseData({
    required this.title,
    required this.minutes,
    required this.progress,
    required this.video,
    required this.description,
    required this.steps,
  });

  factory ExerciseData.fromJson(Map<String, dynamic> json) {
    return ExerciseData(
      title: json['title'] as String,
      minutes: json['minutes'] as int,
      progress: (json['progress'] as num).toDouble(),
      video: json['video'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'minutes': minutes,
      'progress': progress,
      'video': video,
      'description': description,
      'steps': steps,
    };
  }

  @override
  String toString() {
    return 'ExerciseData(title: $title, minutes: $minutes, progress: $progress, video: $video)';
  }
}
