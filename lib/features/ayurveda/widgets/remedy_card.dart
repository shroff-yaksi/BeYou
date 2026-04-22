import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:flutter/material.dart';

class RemedyCard extends StatelessWidget {
  final HomeRemedy remedy;
  final VoidCallback onTap;

  const RemedyCard({super.key, required this.remedy, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(remedy.category.emoji, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remedy.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1F2022),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    remedy.category.label,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF8F98A3)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    remedy.benefits.take(2).join(' · '),
                    style: const TextStyle(fontSize: 11, color: Color(0xFF8F98A3)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFB6BDC6)),
          ],
        ),
      ),
    );
  }
}
