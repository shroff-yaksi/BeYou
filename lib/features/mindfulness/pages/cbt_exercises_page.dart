import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:flutter/material.dart';

class CbtExercisesPage extends StatefulWidget {
  const CbtExercisesPage({super.key});

  @override
  State<CbtExercisesPage> createState() => _CbtExercisesPageState();
}

class _CbtExercisesPageState extends State<CbtExercisesPage> {
  CBTCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final repo = getIt<MindfulnessRepository>();
    final exercises = _filter == null
        ? repo.getAllCBTExercises()
        : repo.getCBTByCategory(_filter!);

    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('CBT, DBT & Grounding'),
        backgroundColor: const Color(0xFF52C78A),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              children: [
                _chip('All', _filter == null, () => setState(() => _filter = null)),
                for (final c in CBTCategory.values)
                  _chip(c.label, _filter == c, () => setState(() => _filter = c)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (_, i) => _exerciseTile(exercises[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool active, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF52C78A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF52C78A).withValues(alpha: 0.3)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFF52C78A),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _exerciseTile(CBTExercise e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        leading: Text(e.emoji, style: const TextStyle(fontSize: 26)),
        title: Text(
          e.title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        subtitle: Text(
          '${e.durationMinutes} min · ${e.category.label}',
          style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 11),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              e.description,
              style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < e.steps.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 11,
                  backgroundColor: const Color(0xFF52C78A),
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.steps[i],
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
