import 'package:shared_preferences/shared_preferences.dart';
import 'package:beyou/features/dosha/models/assessment_result.dart';

/// Repository for persisting dosha assessment history using SharedPreferences.
class DoshaRepository {
  static const _historyKey = 'dosha_assessment_history';

  Future<List<AssessmentResult>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_historyKey);
    if (stored == null) return <AssessmentResult>[];
    return stored.map(AssessmentResult.fromEncoded).toList(growable: false);
  }

  Future<void> saveResult(AssessmentResult result) async {
    final existing = await loadHistory();
    final updated = <AssessmentResult>[result, ...existing];
    final encoded = updated.map((e) => e.toEncoded()).toList(growable: false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, encoded);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
