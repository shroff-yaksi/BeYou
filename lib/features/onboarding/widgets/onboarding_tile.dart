import 'package:flutter/material.dart';
import 'package:beyou/core/constants/color_constants.dart';

class OnboardingTile extends StatelessWidget {
  final String title;
  final String mainText;
  final String imagePath;
  final IconData badgeIcon;

  const OnboardingTile({
    super.key,
    required this.title,
    required this.mainText,
    required this.imagePath,
    this.badgeIcon = Icons.bolt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(child: _buildIllustration()),
          const SizedBox(height: 28),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              color: Color(0xFF1A1A2E),
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            mainText,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.primaryColor.withValues(alpha: 0.06),
          ),
          padding: const EdgeInsets.all(28),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primaryColor.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(badgeIcon, color: Colors.white, size: 22),
          ),
        ),
        Positioned(
          bottom: -6,
          left: -6,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.timer_outlined,
              color: ColorConstants.primaryColor,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
