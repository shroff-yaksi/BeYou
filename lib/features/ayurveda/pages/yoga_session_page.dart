import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/ayurveda/models/yoga_session.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';
import 'package:flutter/material.dart';

class YogaSessionPage extends StatelessWidget {
  final YogaSession session;

  const YogaSessionPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: ColorConstants.primaryColor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                session.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.primaryColor,
                      ColorConstants.primaryColor.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(session.emoji, style: const TextStyle(fontSize: 72)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Meta row
                Row(
                  children: [
                    _MetaBadge(icon: Icons.access_time, label: '${session.durationMinutes} min'),
                    const SizedBox(width: 8),
                    _MetaBadge(icon: Icons.signal_cellular_alt, label: session.level.label),
                    const SizedBox(width: 8),
                    _MetaBadge(icon: Icons.self_improvement, label: session.style.label),
                  ],
                ),
                const SizedBox(height: 20),

                // Description
                const Text(
                  'About This Session',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  session.description,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568), height: 1.6),
                ),
                const SizedBox(height: 24),

                // Benefits
                _SectionCard(
                  title: 'Benefits',
                  emoji: '✨',
                  children: session.benefits
                      .map((b) => _BulletItem(text: b, color: ColorConstants.primaryColor))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Doshas
                const Text(
                  'Good For',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: session.doshas
                      .map((d) => _DoshaChip(dosha: d))
                      .toList(),
                ),
                const SizedBox(height: 30),

                // Start button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showComingSoon(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Start Session',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video player coming soon — Phase 4 media integration')),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F1FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: ColorConstants.primaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: ColorConstants.primaryColor, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _DoshaChip extends StatelessWidget {
  final DoshaType dosha;
  const _DoshaChip({required this.dosha});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: dosha.accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        dosha.label,
        style: TextStyle(color: dosha.accentColor, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String emoji;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.emoji, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ]),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final Color color;

  const _BulletItem({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
