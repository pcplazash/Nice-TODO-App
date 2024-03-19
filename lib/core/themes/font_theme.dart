import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


TextStyle titleFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.merriweather(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: deviceHeight * 0.026,
  );
}

TextStyle bodyFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.lato(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: deviceHeight * 0.02,
  );
}

TextStyle subTitleFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.merriweather(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: deviceHeight * 0.022,
  );
}


TextStyle buttonFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.lato(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: deviceHeight * 0.019,
  );
}

TextStyle smallFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.lato(
    fontWeight: FontWeight.w600,
    color: textColor,
    fontSize: deviceHeight * 0.017,
  );
}

TextStyle branchFontStyle(BuildContext context, Color textColor) {
  final deviceHeight = MediaQuery.of(context).size.height;

  return GoogleFonts.merriweather(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: deviceHeight * 0.025,
  );
}
