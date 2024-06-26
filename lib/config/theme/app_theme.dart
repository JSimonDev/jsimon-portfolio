import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarkMode;
  final quickSand = GoogleFonts.quicksand().fontFamily;
  final dinNextRoundedFontFamily = 'DINNextRounded';

  AppTheme({
    this.isDarkMode = true,
  });

  ThemeData getTheme() => ThemeData(
        ///* General
        colorSchemeSeed: Colors.deepPurple,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,

        ///* Texts
        fontFamily: dinNextRoundedFontFamily,

        ///* TextTheme personalizado
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0),
          bodyLarge: TextStyle(fontSize: 18.0, height: 1.3),
          titleSmall: TextStyle(fontSize: 20.0),
          titleMedium: TextStyle(fontSize: 22.0),
          titleLarge: TextStyle(fontSize: 26.0),
        ),

        ///* AppBar
        appBarTheme: const AppBarTheme(),
      );

  AppTheme copyWith({String? selectedColor, bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
