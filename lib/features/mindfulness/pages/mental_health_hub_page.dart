import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:beyou/features/mindfulness/pages/assessment_page.dart';
import 'package:beyou/features/mindfulness/pages/cbt_exercises_page.dart';
import 'package:beyou/features/mindfulness/pages/crisis_resources_page.dart';
import 'package:flutter/material.dart';

class MentalHealthHubPage extends StatelessWidget {
  const MentalHealthHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Mental Health Hub'),
        backgroundColor: const Color(0xFF52C78A),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _crisisBanner(context),
          const SizedBox(height: 24),
          const Text(
            'Self-assessments',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            'Validated screening tools used by clinicians worldwide. Results stay on-device.',
            style: TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
          ),
          const SizedBox(height: 14),
          ...AssessmentType.values.map((t) => _assessmentTile(context, t)),
          const SizedBox(height: 24),
          const Text(
            'Skills library',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 14),
          _skillsTile(
            context,
            emoji: '🧠',
            title: 'CBT, DBT & Grounding Exercises',
            subtitle: 'Step-by-step skills you can practice in 5–15 minutes.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CbtExercisesPage()),
            ),
          ),
          const SizedBox(height: 12),
          _skillsTile(
            context,
            emoji: '📚',
            title: 'Crisis & Helpline Directory',
            subtitle: '8 verified India helplines + emergency number.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CrisisResourcesPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crisisBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CrisisResourcesPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE74C3C).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE74C3C).withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Text('☎️', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'In crisis right now?',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Color(0xFFC0392B),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tap to see free, confidential 24/7 helplines.',
                    style: TextStyle(color: Color(0xFFC0392B), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFC0392B)),
          ],
        ),
      ),
    );
  }

  Widget _assessmentTile(BuildContext context, AssessmentType type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF52C78A).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('📋', style: TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.label, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  type.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 14),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AssessmentPage(type: type)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillsTile(
    BuildContext context, {
    required String emoji,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: ColorConstants.primaryColor),
          ],
        ),
      ),
    );
  }
}
