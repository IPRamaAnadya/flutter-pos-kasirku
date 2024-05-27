
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/presentations/commons/styles/color.dart';

class AppSText {
  static TextStyle get heading1 => GoogleFonts.openSans(
      fontWeight: FontWeight.w900,
      fontSize: 32,
      color: AppColor.primary700,
    height: 1
  );

  static TextStyle get title => GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: Colors.black
  );

  static TextStyle get body => GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.grey.shade700
  );

  static TextStyle get hint => GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Colors.grey.shade300
  );

  static TextStyle get button => GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.black
  );
}