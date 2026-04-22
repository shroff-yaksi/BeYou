import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/ayurveda/models/ayurveda_program.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final AyurvedaProgram program;
  final VoidCallback onTap;

  const ProgramCard({super.key, required this.program, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.primaryColor.withValues(alpha: 0.7),
                    ColorConstants.primaryColor.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Text(program.emoji, style: const TextStyle(fontSize: 36)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      program.category.label,
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1F2022),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFF8F98A3)),
                      const SizedBox(width: 4),
                      Text(
                        '${program.durationDays} days',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8F98A3)),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.play_circle_outline, size: 12, color: Color(0xFF8F98A3)),
                      const SizedBox(width: 4),
                      Text(
                        '${program.sessions.length} sessions',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF8F98A3)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
