import 'package:cloud_firestore/cloud_firestore.dart';

class BodyMetric {
  final String id;
  final DateTime date;
  final double? weightKg;
  final double? bodyFatPct;
  final double? chest;
  final double? waist;
  final double? hips;
  final double? arms;
  final double? thighs;

  const BodyMetric({
    required this.id,
    required this.date,
    this.weightKg,
    this.bodyFatPct,
    this.chest,
    this.waist,
    this.hips,
    this.arms,
    this.thighs,
  });

  factory BodyMetric.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BodyMetric(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      weightKg: (data['weightKg'] as num?)?.toDouble(),
      bodyFatPct: (data['bodyFatPct'] as num?)?.toDouble(),
      chest: (data['chest'] as num?)?.toDouble(),
      waist: (data['waist'] as num?)?.toDouble(),
      hips: (data['hips'] as num?)?.toDouble(),
      arms: (data['arms'] as num?)?.toDouble(),
      thighs: (data['thighs'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': Timestamp.fromDate(date),
      if (weightKg != null) 'weightKg': weightKg,
      if (bodyFatPct != null) 'bodyFatPct': bodyFatPct,
      if (chest != null) 'chest': chest,
      if (waist != null) 'waist': waist,
      if (hips != null) 'hips': hips,
      if (arms != null) 'arms': arms,
      if (thighs != null) 'thighs': thighs,
    };
  }

  String get dateFormatted {
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
