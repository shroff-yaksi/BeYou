import 'package:flutter/material.dart';
import 'package:beyou/core/constants/path_constants.dart';
import 'package:beyou/core/constants/text_constants.dart';
import 'package:beyou/features/onboarding/widgets/onboarding_tile.dart';

class OnboardingData {
  static List<OnboardingTile> get tiles => [
        OnboardingTile(
          title: TextConstants.onboarding1Title,
          mainText: TextConstants.onboarding1Description,
          imagePath: PathConstants.onboarding1,
          badgeIcon: Icons.bolt,
        ),
        OnboardingTile(
          title: TextConstants.onboarding2Title,
          mainText: TextConstants.onboarding2Description,
          imagePath: PathConstants.onboarding2,
          badgeIcon: Icons.school_outlined,
        ),
        OnboardingTile(
          title: TextConstants.onboarding3Title,
          mainText: TextConstants.onboarding3Description,
          imagePath: PathConstants.onboarding3,
          badgeIcon: Icons.favorite_outline,
        ),
      ];
}
