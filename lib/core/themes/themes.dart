import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class ThemeConfig {
  // Primary and secondary colors

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: secondaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyles.appBarTitle,
      iconTheme: const IconThemeData(color: secondaryColor),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyles.description,
      bodyMedium: TextStyles.smallText,
      titleLarge: TextStyles.headline1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        textStyle: TextStyles.buttonText,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: greyColor,
      titleTextStyle: TextStyles.appBarTitle,
      iconTheme: const IconThemeData(color: secondaryColor),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyles.description.copyWith(color: secondaryColor),
      bodyMedium: TextStyles.smallText.copyWith(color: secondaryColor),
      titleLarge: TextStyles.headline1.copyWith(color: secondaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        textStyle: TextStyles.buttonText,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
