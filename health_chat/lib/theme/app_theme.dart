import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_chat/theme/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightCard,
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.lightText
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        color: AppColors.lightText,
        fontSize: 22,
        fontWeight: FontWeight.bold
      )
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightCard,
      selectedItemColor: AppColors.lightPrimary,
      unselectedItemColor: AppColors.lightSubtext,
      type: BottomNavigationBarType.fixed,
      elevation: 5
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      )
    )
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.darkText
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        color: AppColors.darkText,
        fontSize: 22,
        fontWeight: FontWeight.bold
      )
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCard,
      selectedItemColor: AppColors.darkPrimary,
      unselectedItemColor: AppColors.darkSubtext,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16)
      )
    )

  );
}


