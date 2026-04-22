import 'package:beyou/features/ayurveda/models/pranayama_technique.dart';
import 'package:flutter/material.dart';

class PranayamaCard extends StatelessWidget {
  final PranayamaTechnique technique;
  final VoidCallback onTap;

  const PranayamaCard({super.key, required this.technique, required this.onTap});

  Color get _difficultyColor {
    switch (technique.difficulty) {
      case 'Beginner':
        return const Color(0xFF4CAF50);
      case 'Intermediate':
        return const Color(0xFFFF9800);
      case 'Advanced':
        return const Color(0xFFE53935);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(technique.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 8),
            Text(
              technique.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Color(0xFF1F2022),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              technique.sanskritName,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8F98A3),
                fontStyle: FontStyle.italic,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _difficultyColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                technique.difficulty,
                style: TextStyle(
                  color: _difficultyColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
