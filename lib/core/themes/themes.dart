import 'package:flutter/material.dart';

// Shared color
const Color primaryColor = Color(0xff3c63fe);

// Light theme colors
const Color secondaryColor = Color(0xFFFFFFFF);
const Color darkColor = Color(0xFF333333);
const Color greyColor = Color(0xFF888888);

// Dark theme colors
const Color darkBackground = Color(0xFF121212);
const Color darkSurface = Color(0xFF1E1E1E);
const Color darkOnBackground = Colors.white;
const Color darkOnSurface = Colors.white70;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: greyColor,
    background: Colors.white,
    onBackground: darkColor,
    surface: Colors.white,
    onSurface: darkColor,
    onPrimary: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkBackground,
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    secondary: greyColor,
    background: darkBackground,
    onBackground: darkOnBackground,
    surface: darkSurface,
    onSurface: darkOnSurface,
    onPrimary: Colors.black,
  ),
);
