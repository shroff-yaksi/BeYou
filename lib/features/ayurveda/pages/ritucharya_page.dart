import 'package:beyou/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class _Season {
  final String name;
  final String emoji;
  final String months;
  final Color color;
  final String dominantDosha;
  final String description;
  final List<String> foods;
  final List<String> avoid;
  final List<String> lifestyle;
  final List<String> yoga;
  final List<String> herbs;

  const _Season({
    required this.name,
    required this.emoji,
    required this.months,
    required this.color,
    required this.dominantDosha,
    required this.description,
    required this.foods,
    required this.avoid,
    required this.lifestyle,
    required this.yoga,
    required this.herbs,
  });
}

const _seasons = [
  _Season(
    name: 'Vasanta (Spring)',
    emoji: '🌸',
    months: 'March – April',
    color: Color(0xFF4CAF50),
    dominantDosha: 'Kapha',
    description:
        'Spring is the season of renewal but also Kapha accumulation. As the earth warms, accumulated winter Kapha begins to liquefy, causing congestion, heaviness, and lethargy. The key is to stimulate, lighten, and detoxify.',
    foods: ['Light, dry, spicy foods', 'Barley', 'Millet', 'Bitter greens', 'Legumes', 'Honey (unheated)'],
    avoid: ['Heavy dairy', 'Cold foods', 'Sweets', 'Wheat', 'Oily fried foods'],
    lifestyle: ['Wake early (before 6 AM)', 'Vigorous exercise daily', 'Dry brushing (Garshana)', 'Neti pot daily', 'Reduce sleep'],
    yoga: ['Sun salutations', 'Kapalbhati pranayama', 'Vigorous vinyasa', 'Twists', 'Inversions'],
    herbs: ['Trikatu', 'Tulsi', 'Neem', 'Triphala', 'Ginger'],
  ),
  _Season(
    name: 'Grishma (Summer)',
    emoji: '☀️',
    months: 'May – June',
    color: Color(0xFFFF9800),
    dominantDosha: 'Pitta',
    description:
        'Summer intensifies Pitta through heat, sun, and dryness. The digestive fire weakens in extreme heat. Focus on cooling, hydrating, and soothing practices. Avoid midday sun and competitive exercise.',
    foods: ['Cooling foods', 'Coconut water', 'Sweet fruits', 'Cucumber', 'Coriander', 'Fennel', 'Pomegranate'],
    avoid: ['Spicy food', 'Alcohol', 'Sour foods', 'Red meat', 'Too much salt'],
    lifestyle: ['Sleep adequate hours', 'Moon-bathe at night', 'Cool baths', 'Reduce workload', 'Rest at midday'],
    yoga: ['Moon salutations', 'Yin yoga', 'Sitali pranayama (cooling breath)', 'Forward folds', 'Restorative poses'],
    herbs: ['Amalaki', 'Shatavari', 'Brahmi', 'Neem', 'Aloe vera', 'Rose water'],
  ),
  _Season(
    name: 'Varsha (Monsoon)',
    emoji: '🌧️',
    months: 'July – August',
    color: Color(0xFF2196F3),
    dominantDosha: 'Vata & Pitta',
    description:
        'Monsoon weakens digestion (agni) as humidity and irregular weather aggravate both Vata and Pitta. Eat warm, light, easily digestible foods. This is the season for Panchakarma and cleansing.',
    foods: ['Warm, light soups', 'Old rice', 'Rock salt', 'Ghee', 'Mung dal', 'Bitter vegetables'],
    avoid: ['Raw salads', 'Street food', 'Heavy meat', 'Cold drinks', 'Stale food'],
    lifestyle: ['Avoid waterlogging areas', 'Light exercise only', 'Neem leaves in diet', 'Ideal for Panchakarma', 'Keep feet dry'],
    yoga: ['Gentle hatha', 'Pranayama indoors', 'Nadi Shodhana', 'Mild inversions'],
    herbs: ['Giloy', 'Tulsi', 'Haritaki', 'Kutaj', 'Musta'],
  ),
  _Season(
    name: 'Sharad (Autumn)',
    emoji: '🍂',
    months: 'September – October',
    color: Color(0xFFFF7043),
    dominantDosha: 'Pitta',
    description:
        'Autumn is peak Pitta season — hot days, cool nights, and accumulated Pitta from summer. Blood heat and inflammation peak. This is the time to purify the blood and cool the body before winter arrives.',
    foods: ['Bitter, sweet, astringent foods', 'Pomegranate', 'Dates', 'Green vegetables', 'Light grains'],
    avoid: ['Spicy food', 'Alcohol', 'Sesame oil internally', 'Sour foods', 'Curd'],
    lifestyle: ['Sleep under moonlight', 'Wear white/cool colors', 'Virechana (therapeutic purgation)', 'Avoid harsh sun'],
    yoga: ['Cooling flows', 'Sitali pranayama', 'Restorative', 'Moon salutations', 'Bhramari'],
    herbs: ['Manjistha', 'Guduchi', 'Shatavari', 'Amalaki', 'Chandana (sandalwood)'],
  ),
  _Season(
    name: 'Hemanta (Pre-Winter)',
    emoji: '🌾',
    months: 'November – December',
    color: Color(0xFF795548),
    dominantDosha: 'Vata',
    description:
        'Pre-winter brings dryness, cold, and increased Vata. Digestion is actually stronger in this season. Nourish, ground, and build reserves. This is the season for rasayana (rejuvenating tonics) and building ojas.',
    foods: ['Warm, heavy, oily foods', 'Root vegetables', 'Ghee', 'Sesame', 'Nuts', 'Wheat', 'Dairy', 'Meat (if non-veg)'],
    avoid: ['Cold raw foods', 'Fasting', 'Light foods', 'Caffeine excess'],
    lifestyle: ['Oil massage (Abhyanga) daily', 'Exercise vigorously', 'Build physical strength', 'Adequate sleep (8 hrs)'],
    yoga: ['Grounding hatha', 'Standing poses', 'Ujjayi pranayama', 'Gentle inversions'],
    herbs: ['Ashwagandha', 'Shatavari', 'Bala', 'Chyawanprash', 'Shilajit'],
  ),
  _Season(
    name: 'Shishira (Winter)',
    emoji: '❄️',
    months: 'January – February',
    color: Color(0xFF9C27B0),
    dominantDosha: 'Vata & Kapha',
    description:
        'Deep winter with strong cold and dryness aggravating Vata while Kapha begins accumulating. Maintain warmth, ground the nervous system, and begin preparing for spring cleansing.',
    foods: ['Warming, nutritious foods', 'Soups', 'Ghee', 'Sesame oil', 'Ginger tea', 'Dates', 'Saffron milk'],
    avoid: ['Cold water', 'Raw salads', 'Bitter foods in excess', 'Air conditioning'],
    lifestyle: ['Stay warm', 'Maintain sleep routine', 'Light during day (sun exposure)', 'Start reducing Kapha-building habits'],
    yoga: ['Warming hatha', 'Sun salutations', 'Kapalbhati', 'Warrior poses', 'Backbends'],
    herbs: ['Ginger', 'Turmeric', 'Trikatu', 'Dashamoola', 'Triphala'],
  ),
];

class RitucharyaPage extends StatefulWidget {
  const RitucharyaPage({super.key});

  @override
  State<RitucharyaPage> createState() => _RitucharyaPageState();
}

class _RitucharyaPageState extends State<RitucharyaPage> {
  int _selectedIndex = _currentSeasonIndex();

  static int _currentSeasonIndex() {
    final month = DateTime.now().month;
    if (month == 3 || month == 4) return 0;
    if (month == 5 || month == 6) return 1;
    if (month == 7 || month == 8) return 2;
    if (month == 9 || month == 10) return 3;
    if (month == 11 || month == 12) return 4;
    return 5; // Jan-Feb
  }

  @override
  Widget build(BuildContext context) {
    final season = _seasons[_selectedIndex];

    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2022),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ritucharya', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            Text('Seasonal Guidance', style: TextStyle(fontSize: 11, color: Color(0xFF8F98A3))),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSeasonSelector(),
          Expanded(child: _buildSeasonContent(season)),
        ],
      ),
    );
  }

  Widget _buildSeasonSelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: _seasons.asMap().entries.map((e) {
            final i = e.key;
            final s = e.value;
            final isSelected = i == _selectedIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? s.color : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.emoji, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      s.name.split(' ').first,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF4A5568),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSeasonContent(_Season season) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [season.color, season.color.withValues(alpha: 0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(season.emoji, style: const TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(season.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18)),
                          Text(season.months,
                              style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        season.dominantDosha,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  season.description,
                  style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _ListSection(
              title: 'Recommended Foods',
              emoji: '🥗',
              items: season.foods,
              color: const Color(0xFF4CAF50)),
          const SizedBox(height: 12),
          _ListSection(
              title: 'Foods to Avoid',
              emoji: '🚫',
              items: season.avoid,
              color: const Color(0xFFE53935)),
          const SizedBox(height: 12),
          _ListSection(
              title: 'Lifestyle Practices',
              emoji: '🌿',
              items: season.lifestyle,
              color: season.color),
          const SizedBox(height: 12),
          _ListSection(
              title: 'Yoga & Pranayama',
              emoji: '🧘',
              items: season.yoga,
              color: ColorConstants.primaryColor),
          const SizedBox(height: 12),
          _ListSection(
              title: 'Seasonal Herbs',
              emoji: '🌱',
              items: season.herbs,
              color: const Color(0xFF4CAF50)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  final String title;
  final String emoji;
  final List<String> items;
  final Color color;

  const _ListSection({
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
          Row(children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ]),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item, style: const TextStyle(fontSize: 13))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
