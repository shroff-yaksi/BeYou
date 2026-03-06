import 'package:flutter_test/flutter_test.dart';
import 'package:beyou/data/workout_data.dart';
import 'package:beyou/data/exercise_data.dart';
import 'package:beyou/core/utils/validation_service.dart';
import 'package:beyou/core/service/date_service.dart';

void main() {
  group('ValidationService', () {
    test('email validates correctly', () {
      expect(ValidationService.email('test@example.com'), true);
      expect(ValidationService.email('invalid'), false);
      expect(ValidationService.email(''), false);
    });

    test('password requires minimum 6 characters', () {
      expect(ValidationService.password('123456'), true);
      expect(ValidationService.password('12345'), false);
      expect(ValidationService.password(''), false);
    });

    test('username requires more than 1 character', () {
      expect(ValidationService.username('ab'), true);
      expect(ValidationService.username('a'), false);
    });

    test('confirmPassword matches passwords', () {
      expect(ValidationService.confirmPassword('pass123', 'pass123'), true);
      expect(ValidationService.confirmPassword('pass123', 'pass456'), false);
    });
  });

  group('DateService', () {
    test('converts seconds to minutes and seconds', () {
      final result = DateService.convertIntoSeconds(90);
      expect(result.minutes, 1);
      expect(result.seconds, 30);
    });

    test('handles zero seconds', () {
      final result = DateService.convertIntoSeconds(0);
      expect(result.minutes, 0);
      expect(result.seconds, 0);
    });
  });

  group('ExerciseData', () {
    test('serializes to and from JSON', () {
      final exercise = ExerciseData(
        title: 'Push Ups',
        minutes: 5,
        progress: 0.5,
        video: 'pushups.mp4',
        description: 'A basic push up',
        steps: ['Step 1', 'Step 2'],
      );

      final json = exercise.toJson();
      final restored = ExerciseData.fromJson(json);

      expect(restored.title, exercise.title);
      expect(restored.minutes, exercise.minutes);
      expect(restored.progress, exercise.progress);
      expect(restored.video, exercise.video);
      expect(restored.description, exercise.description);
      expect(restored.steps, exercise.steps);
    });
  });

  group('WorkoutData', () {
    test('serializes to and from JSON', () {
      final workout = WorkoutData(
        title: 'Morning Routine',
        exercices: '5',
        minutes: '30',
        currentProgress: 2,
        progress: 5,
        image: 'morning.png',
        exerciseDataList: [
          ExerciseData(
            title: 'Squats',
            minutes: 3,
            progress: 1.0,
            video: 'squats.mp4',
            description: 'Basic squats',
            steps: ['Stand up', 'Squat down'],
          ),
        ],
      );

      final json = workout.toJson();
      final restored = WorkoutData.fromJson(json);

      expect(restored.title, workout.title);
      expect(restored.exercices, workout.exercices);
      expect(restored.minutes, workout.minutes);
      expect(restored.currentProgress, workout.currentProgress);
      expect(restored.progress, workout.progress);
      expect(restored.image, workout.image);
      expect(restored.exerciseDataList.length, 1);
      expect(restored.exerciseDataList.first.title, 'Squats');
    });
  });
}
