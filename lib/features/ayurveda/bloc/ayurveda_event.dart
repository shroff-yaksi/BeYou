import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/ayurveda/models/yoga_session.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

abstract class AyurvedaEvent {}

class AyurvedaStarted extends AyurvedaEvent {}

class AyurvedaYogaFilterChanged extends AyurvedaEvent {
  final YogaStyle? style; // null = show all
  AyurvedaYogaFilterChanged(this.style);
}

class AyurvedaRemedySearchChanged extends AyurvedaEvent {
  final String query;
  AyurvedaRemedySearchChanged(this.query);
}

class AyurvedaRemedyCategoryChanged extends AyurvedaEvent {
  final RemedyCategory? category; // null = show all
  AyurvedaRemedyCategoryChanged(this.category);
}

class AyurvedaDoshaFilterChanged extends AyurvedaEvent {
  final DoshaType? dosha;
  AyurvedaDoshaFilterChanged(this.dosha);
}
