import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytheme {
  static final TextStyle textLogin = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.w800, color: Colors.green);
  static final TextStyle hAppTitle = GoogleFonts.grandHotel(
      fontSize: 40, color: Colors.pink, fontWeight: FontWeight.w500);
  static final TextStyle textName = GoogleFonts.dongle(
      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
  static const kPrimaryColor = Color(0xFFFF7643);
  static const kBackgroundColor = Color(0xFFFFFFFF);
  static const kSecondaryColor = Color(0xFF979797);
  static const kTextColor = Color(0xFF272727);
  static const kAnimationDuration = Duration(milliseconds: 200);
}
