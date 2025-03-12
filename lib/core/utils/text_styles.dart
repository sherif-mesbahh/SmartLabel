import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class TextStyles {
  static TextStyle headline1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: darkColor,
  );

  static TextStyle headline2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: darkColor,
  );

  static TextStyle productTitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: darkColor,
  );

  static TextStyle productPrice = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle productOldPrice = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: greyColor,
    decoration: TextDecoration.lineThrough,
  );

  static TextStyle description = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: greyColor,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static TextStyle smallText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: greyColor,
  );

  static TextStyle cartItemTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: darkColor,
  );

  static TextStyle cartItemPrice = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle appBarTitle = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static TextStyle discountText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );
}
