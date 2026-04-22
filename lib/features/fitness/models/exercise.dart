import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final String name;
  final List<String> muscleGroups;
  final List<String> equipment;
  final String category;
  final String? gifUrl;
  final String? videoAsset;
  final List<String> instructions;
  final String difficulty;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroups,
    required this.equipment,
    required this.category,
    this.gifUrl,
    this.videoAsset,
    required this.instructions,
    required this.difficulty,
  });

  factory Exercise.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exercise(
      id: doc.id,
      name: data['name'] as String,
      muscleGroups: (data['muscleGroups'] as List<dynamic>? ?? []).cast<String>(),
      equipment: (data['equipment'] as List<dynamic>? ?? []).cast<String>(),
      category: data['category'] as String,
      gifUrl: data['gifUrl'] as String?,
      videoAsset: data['videoAsset'] as String?,
      instructions: (data['instructions'] as List<dynamic>? ?? []).cast<String>(),
      difficulty: data['difficulty'] as String,
    );
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> data) {
    return Exercise(
      id: id,
      name: data['name'] as String,
      muscleGroups: (data['muscleGroups'] as List<dynamic>? ?? []).cast<String>(),
      equipment: (data['equipment'] as List<dynamic>? ?? []).cast<String>(),
      category: data['category'] as String,
      gifUrl: data['gifUrl'] as String?,
      videoAsset: data['videoAsset'] as String?,
      instructions: (data['instructions'] as List<dynamic>? ?? []).cast<String>(),
      difficulty: data['difficulty'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'muscleGroups': muscleGroups,
      'equipment': equipment,
      'category': category,
      if (gifUrl != null) 'gifUrl': gifUrl,
      if (videoAsset != null) 'videoAsset': videoAsset,
      'instructions': instructions,
      'difficulty': difficulty,
    };
  }
}
