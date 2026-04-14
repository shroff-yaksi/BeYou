import 'package:flutter/material.dart';
import 'package:beyou/core/constants/color_constants.dart';

/// App theme configuration using existing ColorConstants
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  /// Light theme for the app
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ColorConstants.primaryColor,
      scaffoldBackgroundColor: ColorConstants.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.primaryColor,
        primary: ColorConstants.primaryColor,
        onPrimary: ColorConstants.white,
        secondary: ColorConstants.primaryColor,
        surface: ColorConstants.white,
        onSurface: ColorConstants.textBlack,
        error: ColorConstants.errorColor,
      ),
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstants.textColor),
        titleTextStyle: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'NotoSansKR',
        ),
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSansKR',
        ),
        displayMedium: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSansKR',
        ),
        displaySmall: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'NotoSansKR',
        ),
        headlineMedium: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'NotoSansKR',
        ),
        titleLarge: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'NotoSansKR',
        ),
        bodyLarge: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 16,
          fontFamily: 'NotoSansKR',
        ),
        bodyMedium: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 14,
          fontFamily: 'NotoSansKR',
        ),
        bodySmall: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 12,
          fontFamily: 'NotoSansKR',
        ),
      ),
      
      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor,
          foregroundColor: ColorConstants.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'NotoSansKR',
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorConstants.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: ColorConstants.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: ColorConstants.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: ColorConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintStyle: const TextStyle(
          color: ColorConstants.grey,
          fontSize: 14,
          fontFamily: 'NotoSansKR',
        ),
      ),
      
      // Card theme
      cardTheme: const CardThemeData(
        color: ColorConstants.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorConstants.white,
        selectedItemColor: ColorConstants.primaryColor,
        unselectedItemColor: ColorConstants.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      fontFamily: 'NotoSansKR',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
    );
  }
}
