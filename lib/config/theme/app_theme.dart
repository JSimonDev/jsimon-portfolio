import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Colors.deepPurple;

const Map<String, Color> colorMap = {
  "Azul": Colors.blue,
  "Indigo": Colors.indigo,
  "Morado Oscuro": Colors.deepPurple,
  "Morado": Colors.purple,
  "Rosado": Colors.pink,
  "Rojo": Colors.red,
  "Naranja": Colors.orange,
  "Verde Lima": Colors.lime,
  "Verde": Colors.green,
  "Verde Azul": Colors.teal,
};

class AppTheme {
  final String selectedColor;
  final bool isDarkMode;
  final fontFamily = GoogleFonts.quicksand();
  final fallbackFontFamily = GoogleFonts.notoSans();

  AppTheme({
    this.selectedColor = "Morado Oscuro",
    this.isDarkMode = true,
  });

  ThemeData getTheme() => ThemeData(
        ///* General
        colorSchemeSeed: colorMap[selectedColor],
        brightness: isDarkMode ? Brightness.dark : Brightness.light,

        ///* Texts
        fontFamily: fontFamily.fontFamily,
        fontFamilyFallback: [fallbackFontFamily.fontFamily!],

        ///* Scaffold Background Color
        // scaffoldBackgroundColor: scaffoldBackgroundColor,

        ///* Buttons
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              fontFamily.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),

        ///* AppBar
        appBarTheme: const AppBarTheme(),
      );

  AppTheme copyWith({String? selectedColor, bool? isDarkMode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
