import 'package:beyou/features/ayurveda/models/ayurveda_program.dart';
import 'package:beyou/features/ayurveda/models/dinacharya_item.dart';
import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/ayurveda/models/pranayama_technique.dart';
import 'package:beyou/features/ayurveda/models/yoga_session.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

abstract class AyurvedaState {}

class AyurvedaInitial extends AyurvedaState {}

class AyurvedaLoading extends AyurvedaState {}

class AyurvedaLoaded extends AyurvedaState {
  final List<YogaSession> yogaSessions;
  final List<PranayamaTechnique> pranayamaTechniques;
  final List<HomeRemedy> remedies;
  final List<DinacharyaItem> morningRoutine;
  final List<DinacharyaItem> eveningRoutine;
  final List<AyurvedaProgram> programs;
  final YogaStyle? activeYogaFilter;
  final RemedyCategory? activeRemedyCategory;
  final String remedySearchQuery;
  final DoshaType? userDosha; // null if not yet assessed

  AyurvedaLoaded({
    required this.yogaSessions,
    required this.pranayamaTechniques,
    required this.remedies,
    required this.morningRoutine,
    required this.eveningRoutine,
    required this.programs,
    this.activeYogaFilter,
    this.activeRemedyCategory,
    this.remedySearchQuery = '',
    this.userDosha,
  });

  AyurvedaLoaded copyWith({
    List<YogaSession>? yogaSessions,
    List<PranayamaTechnique>? pranayamaTechniques,
    List<HomeRemedy>? remedies,
    List<DinacharyaItem>? morningRoutine,
    List<DinacharyaItem>? eveningRoutine,
    List<AyurvedaProgram>? programs,
    YogaStyle? activeYogaFilter,
    bool clearYogaFilter = false,
    RemedyCategory? activeRemedyCategory,
    bool clearRemedyCategory = false,
    String? remedySearchQuery,
    DoshaType? userDosha,
  }) {
    return AyurvedaLoaded(
      yogaSessions: yogaSessions ?? this.yogaSessions,
      pranayamaTechniques: pranayamaTechniques ?? this.pranayamaTechniques,
      remedies: remedies ?? this.remedies,
      morningRoutine: morningRoutine ?? this.morningRoutine,
      eveningRoutine: eveningRoutine ?? this.eveningRoutine,
      programs: programs ?? this.programs,
      activeYogaFilter: clearYogaFilter ? null : (activeYogaFilter ?? this.activeYogaFilter),
      activeRemedyCategory: clearRemedyCategory ? null : (activeRemedyCategory ?? this.activeRemedyCategory),
      remedySearchQuery: remedySearchQuery ?? this.remedySearchQuery,
      userDosha: userDosha ?? this.userDosha,
    );
  }
}

class AyurvedaError extends AyurvedaState {
  final String message;
  AyurvedaError(this.message);
}
