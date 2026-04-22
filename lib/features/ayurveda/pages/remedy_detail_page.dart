import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';
import 'package:flutter/material.dart';

class RemedyDetailPage extends StatelessWidget {
  final HomeRemedy remedy;

  const RemedyDetailPage({super.key, required this.remedy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: ColorConstants.primaryColor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                remedy.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                maxLines: 2,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.primaryColor,
                      ColorConstants.primaryColor.withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(remedy.category.emoji, style: const TextStyle(fontSize: 64)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Category + Dosha badges
                Row(
                  children: [
                    _Badge(label: remedy.category.label, color: ColorConstants.primaryColor),
                    const SizedBox(width: 8),
                    ...remedy.doshas.map((d) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: _Badge(label: d.label, color: d.accentColor),
                        )),
                  ],
                ),
                const SizedBox(height: 20),

                // Ingredients
                _DetailCard(
                  title: 'Ingredients',
                  emoji: '🧪',
                  child: Column(
                    children: remedy.ingredients
                        .map((i) => _BulletRow(text: i, color: ColorConstants.primaryColor))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 14),

                // Preparation
                _DetailCard(
                  title: 'How to Prepare',
                  emoji: '🍵',
                  child: Text(
                    remedy.preparation,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568), height: 1.7),
                  ),
                ),
                const SizedBox(height: 14),

                // Usage
                _DetailCard(
                  title: 'How to Use',
                  emoji: '📅',
                  child: Text(
                    remedy.usage,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568), height: 1.7),
                  ),
                ),
                const SizedBox(height: 14),

                // Benefits
                _DetailCard(
                  title: 'Benefits',
                  emoji: '✨',
                  child: Column(
                    children: remedy.benefits
                        .map((b) => _BulletRow(text: b, color: const Color(0xFF4CAF50)))
                        .toList(),
                  ),
                ),

                // Caution
                if (remedy.caution != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFFFF9800).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('⚠️', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            remedy.caution!,
                            style: const TextStyle(
                                color: Color(0xFF6D4C41), fontSize: 13, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Widget child;

  const _DetailCard({required this.title, required this.emoji, required this.child});

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
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ]),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;
  final Color color;

  const _BulletRow({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
                width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, height: 1.5))),
        ],
      ),
    );
  }
}
