import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';
import 'package:flutter/material.dart';

class DoshaProfilePage extends StatelessWidget {
  final DoshaType dosha;

  const DoshaProfilePage({super.key, required this.dosha});

  Map<String, dynamic> get _profile {
    switch (dosha) {
      case DoshaType.vata:
        return {
          'element': 'Air & Space',
          'qualities': ['Light', 'Dry', 'Cold', 'Mobile', 'Subtle'],
          'strengths': ['Creative', 'Enthusiastic', 'Quick-learner', 'Flexible', 'Intuitive'],
          'imbalance': ['Anxiety', 'Dry skin', 'Constipation', 'Insomnia', 'Cold extremities'],
          'foods': ['Warm, oily, heavy foods', 'Root vegetables', 'Ghee', 'Nuts', 'Sweet fruits'],
          'avoid': ['Raw, cold foods', 'Caffeine', 'Dry snacks', 'Carbonated drinks'],
          'yoga': ['Grounding poses', 'Slow flow', 'Yin yoga', 'Child\'s pose', 'Mountain pose'],
          'mantra': 'I am grounded, stable, and at peace.',
          'season': 'Autumn & Early Winter',
          'bestTime': 'Morning routine consistency is key for Vata.',
        };
      case DoshaType.pitta:
        return {
          'element': 'Fire & Water',
          'qualities': ['Hot', 'Sharp', 'Light', 'Liquid', 'Oily'],
          'strengths': ['Focused', 'Intelligent', 'Courageous', 'Organized', 'Leadership'],
          'imbalance': ['Anger', 'Inflammation', 'Acid reflux', 'Skin rashes', 'Perfectionism'],
          'foods': ['Cooling foods', 'Sweet fruits', 'Cucumbers', 'Coconut', 'Dairy', 'Coriander'],
          'avoid': ['Spicy food', 'Alcohol', 'Fried food', 'Red meat', 'Fermented foods'],
          'yoga': ['Cooling flows', 'Moon salutations', 'Forward folds', 'Restorative yoga'],
          'mantra': 'I act with compassion, not perfection.',
          'season': 'Summer & Late Spring',
          'bestTime': 'Practice moderation — Pitta tends toward overwork.',
        };
      case DoshaType.kapha:
        return {
          'element': 'Earth & Water',
          'qualities': ['Heavy', 'Slow', 'Cool', 'Oily', 'Smooth', 'Dense'],
          'strengths': ['Loyal', 'Calm', 'Patient', 'Strong', 'Nurturing', 'Reliable'],
          'imbalance': ['Lethargy', 'Weight gain', 'Depression', 'Congestion', 'Attachment'],
          'foods': ['Light, dry, warm foods', 'Legumes', 'Vegetables', 'Spices', 'Bitter greens'],
          'avoid': ['Heavy dairy', 'Sweets', 'Fried food', 'Cold drinks', 'Wheat'],
          'yoga': ['Vigorous vinyasa', 'Ashtanga', 'Sun salutations', 'Twists', 'Breath of fire'],
          'mantra': 'I embrace change with joy and enthusiasm.',
          'season': 'Late Winter & Spring',
          'bestTime': 'Exercise in the morning when Kapha energy is highest.',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;
    final color = dosha.accentColor;

    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: color,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                '${dosha.label} Profile',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text('🌀', style: TextStyle(fontSize: 60)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _InfoCard(
                  color: color,
                  title: 'Element',
                  content: profile['element'] as String,
                  emoji: '🌍',
                ),
                const SizedBox(height: 16),
                _ChipSection(
                  title: 'Qualities',
                  emoji: '✨',
                  chips: (profile['qualities'] as List<String>),
                  chipColor: color,
                ),
                const SizedBox(height: 16),
                _ChipSection(
                  title: 'Strengths',
                  emoji: '💪',
                  chips: (profile['strengths'] as List<String>),
                  chipColor: const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 16),
                _ChipSection(
                  title: 'Signs of Imbalance',
                  emoji: '⚠️',
                  chips: (profile['imbalance'] as List<String>),
                  chipColor: const Color(0xFFFF7043),
                ),
                const SizedBox(height: 16),
                _ListCard(
                  title: 'Recommended Foods',
                  emoji: '🥗',
                  items: (profile['foods'] as List<String>),
                  color: const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 16),
                _ListCard(
                  title: 'Foods to Avoid',
                  emoji: '🚫',
                  items: (profile['avoid'] as List<String>),
                  color: const Color(0xFFFF7043),
                ),
                const SizedBox(height: 16),
                _ListCard(
                  title: 'Yoga for Your Dosha',
                  emoji: '🧘',
                  items: (profile['yoga'] as List<String>),
                  color: color,
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  color: color,
                  title: 'Daily Mantra',
                  content: '"${profile['mantra']}"',
                  emoji: '🙏',
                ),
                const SizedBox(height: 16),
                _InfoCard(
                  color: color,
                  title: 'Peak Season',
                  content: '${profile['season']}\n\n${profile['bestTime']}',
                  emoji: '🍂',
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content;
  final String emoji;

  const _InfoCard({
    required this.color,
    required this.title,
    required this.content,
    required this.emoji,
  });

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 14, color: Color(0xFF1F2022))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipSection extends StatelessWidget {
  final String title;
  final String emoji;
  final List<String> chips;
  final Color chipColor;

  const _ChipSection({
    required this.title,
    required this.emoji,
    required this.chips,
    required this.chipColor,
  });

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
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips
                .map((c) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: chipColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(c,
                          style: TextStyle(
                              color: chipColor, fontSize: 12, fontWeight: FontWeight.w600)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final String title;
  final String emoji;
  final List<String> items;
  final Color color;

  const _ListCard({
    required this.title,
    required this.emoji,
    required this.items,
    required this.color,
  });

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
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Text(item, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
