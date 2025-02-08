import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color black = Color(0xFF171717);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFA0A0A0);
  static ThemeData lightTheme = ThemeData(
    primaryColor: black,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: black,
      surfaceTintColor: black,
      foregroundColor: white,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
    ),
    scaffoldBackgroundColor: black,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: white,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: grey,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
