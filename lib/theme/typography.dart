import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

// Simple
TextStyle headlineTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 26.sp,
        color: textSecondary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600));

TextStyle headlineSecondaryTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 20.sp, color: textPrimary, fontWeight: FontWeight.w300));

TextStyle subtitleTextStyle = GoogleFonts.openSans(
    textStyle:
        TextStyle(fontSize: 16.sp, color: textSecondary, letterSpacing: 1));

TextStyle bodyTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 14.sp, color: textPrimary));

TextStyle buttonTextStyle = GoogleFonts.montserrat(
    textStyle:
        TextStyle(fontSize: 14.sp, color: textPrimary, letterSpacing: 1));
TextStyle buttonTextStyle1 = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 20.sp,
        color: textPrimary,
        letterSpacing: 1,
        fontWeight: FontWeight.w500));

// Advanced
// TODO: Add additional text styles.
TextStyle headline1TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 2,
        color: textPrimary,
        letterSpacing: 5,
        fontWeight: FontWeight.w600));

TextStyle headline2TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 1.5,
        color: textPrimary,
        letterSpacing: 5,
        fontWeight: FontWeight.w600,
        height: 1.7));

TextStyle headline3TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 1.17,
        color: textPrimary,
        letterSpacing: 5,
        fontWeight: FontWeight.w600,
        height: 1.7));

TextStyle headline4TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 1,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w400));

TextStyle headline5TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 0.83,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w400));

TextStyle headline6TextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 0.67,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w400));

TextStyle headline6BoldTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: headline6TextStyle.fontSize,
        color: textPrimary,
        letterSpacing: headline6TextStyle.letterSpacing,
        fontWeight: FontWeight.w600));

TextStyle headline6SelectedTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: headline6TextStyle.fontSize,
        color: textSelected,
        letterSpacing: headline6TextStyle.letterSpacing,
        fontWeight: FontWeight.w600));

TextStyle paragraphTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 16 * 0.6,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w400));
