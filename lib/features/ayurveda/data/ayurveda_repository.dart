import 'package:beyou/features/ayurveda/data/ayurveda_seed_data.dart';
import 'package:beyou/features/ayurveda/models/ayurveda_program.dart';
import 'package:beyou/features/ayurveda/models/dinacharya_item.dart';
import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/ayurveda/models/pranayama_technique.dart';
import 'package:beyou/features/ayurveda/models/yoga_session.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

class AyurvedaRepository {
  // ── Yoga ──────────────────────────────────────
  List<YogaSession> getAllYogaSessions() => AyurvedaSeedData.yogaSessions;

  List<YogaSession> getYogaByStyle(YogaStyle style) =>
      AyurvedaSeedData.yogaSessions.where((s) => s.style == style).toList();

  List<YogaSession> getYogaForDosha(DoshaType dosha) =>
      AyurvedaSeedData.yogaSessions.where((s) => s.doshas.contains(dosha)).toList();

  // ── Pranayama ─────────────────────────────────
  List<PranayamaTechnique> getAllPranayama() => AyurvedaSeedData.pranayamaTechniques;

  List<PranayamaTechnique> getPranayamaForDosha(DoshaType dosha) =>
      AyurvedaSeedData.pranayamaTechniques.where((p) => p.doshas.contains(dosha)).toList();

  // ── Remedies ──────────────────────────────────
  List<HomeRemedy> getAllRemedies() => AyurvedaSeedData.homeRemedies;

  List<HomeRemedy> getRemediesByCategory(RemedyCategory category) =>
      AyurvedaSeedData.homeRemedies.where((r) => r.category == category).toList();

  List<HomeRemedy> getRemediesForDosha(DoshaType dosha) =>
      AyurvedaSeedData.homeRemedies.where((r) => r.doshas.contains(dosha)).toList();

  List<HomeRemedy> searchRemedies(String query) {
    final q = query.toLowerCase();
    return AyurvedaSeedData.homeRemedies
        .where((r) =>
            r.title.toLowerCase().contains(q) ||
            r.ingredients.any((i) => i.toLowerCase().contains(q)) ||
            r.benefits.any((b) => b.toLowerCase().contains(q)))
        .toList();
  }

  // ── Dinacharya ────────────────────────────────
  List<DinacharyaItem> getMorningRoutine() =>
      AyurvedaSeedData.dinacharyaItems.where((d) => d.period == DinacharyaPeriod.morning).toList();

  List<DinacharyaItem> getEveningRoutine() =>
      AyurvedaSeedData.dinacharyaItems.where((d) => d.period == DinacharyaPeriod.evening).toList();

  List<DinacharyaItem> getDinacharyaForDosha(DoshaType dosha) {
    return AyurvedaSeedData.dinacharyaItems
        .where((d) => d.doshas.isEmpty || d.doshas.contains(dosha))
        .toList();
  }

  // ── Programs ──────────────────────────────────
  List<AyurvedaProgram> getAllPrograms() => AyurvedaSeedData.programs;

  List<AyurvedaProgram> getProgramsByCategory(ProgramCategory category) =>
      AyurvedaSeedData.programs.where((p) => p.category == category).toList();

  List<AyurvedaProgram> getProgramsForDosha(DoshaType dosha) =>
      AyurvedaSeedData.programs.where((p) => p.doshas.isEmpty || p.doshas.contains(dosha)).toList();
}
