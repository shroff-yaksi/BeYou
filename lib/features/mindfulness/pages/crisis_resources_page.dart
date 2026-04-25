import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CrisisResourcesPage extends StatelessWidget {
  const CrisisResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = getIt<MindfulnessRepository>().getCrisisResources();
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Crisis & Helplines'),
        backgroundColor: const Color(0xFFE74C3C),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'If you are in immediate danger, dial 112 (India\'s unified emergency number) '
              'or go to the nearest emergency room.',
              style: TextStyle(fontSize: 13, color: Color(0xFF6E6A52), height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          ...resources.map((r) => _resourceCard(context, r)),
        ],
      ),
    );
  }

  Widget _resourceCard(BuildContext context, CrisisResource r) {
    final isEmergency = r.kind == CrisisResourceKind.emergency;
    final color = isEmergency ? const Color(0xFFE74C3C) : ColorConstants.primaryColor;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  r.name,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  r.hours,
                  style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            r.description,
            style: const TextStyle(color: Color(0xFF555555), fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _call(r.phone),
                  icon: const Icon(Icons.call, size: 18),
                  label: Text(r.phone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              if (r.website != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _open('https://${r.website!}'),
                  icon: const Icon(Icons.open_in_new),
                  color: color,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _call(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
