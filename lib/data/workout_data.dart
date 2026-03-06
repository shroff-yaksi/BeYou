import 'package:beyou/data/exercise_data.dart';

class WorkoutData {
  final String title;
  final String exercices;
  final String minutes;
  final int currentProgress;
  final int progress;
  final String image;
  final List<ExerciseData> exerciseDataList;

  WorkoutData({
    required this.title,
    required this.exercices,
    required this.minutes,
    required this.currentProgress,
    required this.progress,
    required this.image,
    required this.exerciseDataList,
  });

  factory WorkoutData.fromJson(Map<String, dynamic> json) {
    return WorkoutData(
      title: json['title'] as String,
      exercices: json['exercices'] as String,
      minutes: json['minutes'] as String,
      currentProgress: json['currentProgress'] as int,
      progress: json['progress'] as int,
      image: json['image'] as String,
      exerciseDataList: (json['exerciseDataList'] as List)
          .map((e) => ExerciseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'exercices': exercices,
      'minutes': minutes,
      'currentProgress': currentProgress,
      'progress': progress,
      'image': image,
      'exerciseDataList': exerciseDataList.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'WorkoutData(title: $title, exercices: $exercices, minutes: $minutes, currentProgress: $currentProgress, progress: $progress, image: $image, exerciseDataList: $exerciseDataList)';
  }
}
