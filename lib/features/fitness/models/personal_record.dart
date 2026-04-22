import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalRecord {
  final String exerciseId;
  final String exerciseName;
  final double bestWeightKg;
  final int bestReps;
  final DateTime achievedAt;

  const PersonalRecord({
    required this.exerciseId,
    required this.exerciseName,
    required this.bestWeightKg,
    required this.bestReps,
    required this.achievedAt,
  });

  factory PersonalRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PersonalRecord(
      exerciseId: doc.id,
      exerciseName: data['exerciseName'] as String,
      bestWeightKg: (data['bestWeightKg'] as num).toDouble(),
      bestReps: (data['bestReps'] as num).toInt(),
      achievedAt: (data['achievedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'exerciseName': exerciseName,
      'bestWeightKg': bestWeightKg,
      'bestReps': bestReps,
      'achievedAt': Timestamp.fromDate(achievedAt),
    };
  }

  String get dateFormatted {
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${achievedAt.day} ${months[achievedAt.month - 1]} ${achievedAt.year}';
  }

  String get weightFormatted {
    if (bestWeightKg == 0) return 'Bodyweight';
    return '${bestWeightKg.toStringAsFixed(1)} kg';
  }
}
