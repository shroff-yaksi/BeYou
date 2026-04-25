import 'package:hive/hive.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_seed_data.dart';
import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:beyou/features/mindfulness/models/focus_session.dart';
import 'package:beyou/features/mindfulness/models/meditation_session.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:beyou/features/mindfulness/models/sleep_content.dart';
import 'package:beyou/features/mindfulness/models/sos_session.dart';

/// Hive box names — kept on the repository so the rest of the app does not
/// touch storage details directly.
const _kMoodBox = 'mindfulness_mood_entries';
const _kAddictionBox = 'mindfulness_addiction_trackers';
const _kMeditationHistoryBox = 'mindfulness_meditation_history';
const _kFocusBox = 'mindfulness_focus_sessions';

class MindfulnessRepository {
  // ── Static content ────────────────────────────────────────────────
  List<MeditationSession> getAllMeditations() => MindfulnessSeedData.meditations;

  List<MeditationSession> getMeditationsByCategory(MeditationCategory c) =>
      MindfulnessSeedData.meditations.where((m) => m.category == c).toList();

  MeditationSession? getMeditationById(String id) {
    for (final m in MindfulnessSeedData.meditations) {
      if (m.id == id) return m;
    }
    return null;
  }

  List<SleepContent> getAllSleepContent() => MindfulnessSeedData.sleepContent;

  List<SleepContent> getSleepByType(SleepContentType t) =>
      MindfulnessSeedData.sleepContent.where((s) => s.type == t).toList();

  List<SosSession> getAllSosSessions() => MindfulnessSeedData.sosSessions;

  List<CBTExercise> getAllCBTExercises() => MindfulnessSeedData.cbtExercises;

  List<CBTExercise> getCBTByCategory(CBTCategory c) =>
      MindfulnessSeedData.cbtExercises.where((e) => e.category == c).toList();

  List<CrisisResource> getCrisisResources() => MindfulnessSeedData.crisisResources;

  MentalHealthAssessment getAssessment(AssessmentType type) {
    switch (type) {
      case AssessmentType.gad7:
        return MindfulnessSeedData.gad7;
      case AssessmentType.phq9:
        return MindfulnessSeedData.phq9;
      case AssessmentType.pss10:
        return MindfulnessSeedData.pss10;
    }
  }

  // ── Hive box openers (idempotent) ─────────────────────────────────
  Future<Box> _openMoodBox() async =>
      Hive.isBoxOpen(_kMoodBox) ? Hive.box(_kMoodBox) : await Hive.openBox(_kMoodBox);

  Future<Box> _openAddictionBox() async => Hive.isBoxOpen(_kAddictionBox)
      ? Hive.box(_kAddictionBox)
      : await Hive.openBox(_kAddictionBox);

  Future<Box> _openMeditationHistoryBox() async => Hive.isBoxOpen(_kMeditationHistoryBox)
      ? Hive.box(_kMeditationHistoryBox)
      : await Hive.openBox(_kMeditationHistoryBox);

  Future<Box> _openFocusBox() async =>
      Hive.isBoxOpen(_kFocusBox) ? Hive.box(_kFocusBox) : await Hive.openBox(_kFocusBox);

  // ── Mood Journal ──────────────────────────────────────────────────
  Future<List<MoodEntry>> getMoodEntries() async {
    final box = await _openMoodBox();
    return box.values
        .map((v) => MoodEntry.fromJson(Map<dynamic, dynamic>.from(v as Map)))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> saveMoodEntry(MoodEntry entry) async {
    final box = await _openMoodBox();
    await box.put(entry.id, entry.toJson());
  }

  Future<void> deleteMoodEntry(String id) async {
    final box = await _openMoodBox();
    await box.delete(id);
  }

  // ── I Am Clean ────────────────────────────────────────────────────
  Future<List<AddictionTracker>> getAddictionTrackers() async {
    final box = await _openAddictionBox();
    return box.values
        .map((v) => AddictionTracker.fromJson(Map<dynamic, dynamic>.from(v as Map)))
        .toList();
  }

  Future<void> saveAddictionTracker(AddictionTracker tracker) async {
    final box = await _openAddictionBox();
    await box.put(tracker.type.index, tracker.toJson());
  }

  Future<void> deleteAddictionTracker(AddictionType type) async {
    final box = await _openAddictionBox();
    await box.delete(type.index);
  }

  // ── Meditation History (for streak) ───────────────────────────────
  Future<List<DateTime>> getMeditationHistory() async {
    final box = await _openMeditationHistoryBox();
    return box.values
        .map((v) => DateTime.parse(v as String))
        .toList()
      ..sort();
  }

  Future<void> logMeditationCompletion(String sessionId) async {
    final box = await _openMeditationHistoryBox();
    final now = DateTime.now();
    await box.add(now.toIso8601String());
  }

  /// Calculates the consecutive-day meditation streak.
  Future<int> getMeditationStreak() async {
    final history = await getMeditationHistory();
    if (history.isEmpty) return 0;

    final daysSet = history
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    int streak = 0;
    DateTime cursor = DateTime.now();
    cursor = DateTime(cursor.year, cursor.month, cursor.day);

    // Allow today OR yesterday to start the streak.
    if (!daysSet.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!daysSet.contains(cursor)) return 0;
    }

    while (daysSet.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // ── Focus Sessions ────────────────────────────────────────────────
  Future<List<FocusSession>> getFocusSessions() async {
    final box = await _openFocusBox();
    return box.values
        .map((v) => FocusSession.fromJson(Map<dynamic, dynamic>.from(v as Map)))
        .toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
  }

  Future<void> saveFocusSession(FocusSession session) async {
    final box = await _openFocusBox();
    await box.put(session.id, session.toJson());
  }
}
