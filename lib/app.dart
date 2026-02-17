import 'package:flutter/material.dart';
import 'package:beyou/core/theme/app_theme.dart';
import 'package:beyou/core/router/app_router.dart';

/// Main BeYou application widget
class BeYouApp extends StatelessWidget {
  const BeYouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BeYou - Your Complete Wellness Journey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
