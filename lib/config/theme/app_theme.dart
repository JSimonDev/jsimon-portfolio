import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarkMode;
  final fontFamily = GoogleFonts.quicksand();

  AppTheme({
    this.isDarkMode = true,
  });

  ThemeData getTheme() => ThemeData(
        ///* General
        colorSchemeSeed: Colors.deepPurple,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,

        ///* Texts
        fontFamily: fontFamily.fontFamily,

        ///* AppBar
        appBarTheme: const AppBarTheme(),
      );

  AppTheme copyWith({String? selectedColor, bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
