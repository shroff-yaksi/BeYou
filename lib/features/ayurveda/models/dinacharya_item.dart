import 'package:beyou/features/dosha/models/dosha_type.dart';

enum DinacharyaPeriod { morning, evening }

class DinacharyaItem {
  final String id;
  final String title;
  final String timeRange;   // e.g. "5:00–6:00 AM"
  final DinacharyaPeriod period;
  final String description;
  final String emoji;
  final List<DoshaType> doshas; // empty = all doshas
  final int durationMinutes;

  const DinacharyaItem({
    required this.id,
    required this.title,
    required this.timeRange,
    required this.period,
    required this.description,
    required this.emoji,
    required this.doshas,
    required this.durationMinutes,
  });
}
