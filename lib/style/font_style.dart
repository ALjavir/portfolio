import 'package:flutter/material.dart';

class Fontstyle {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static TextStyle topBarFont(BuildContext context, double fontSize) {
    return TextStyle(
      fontFamily: 'HousttelySignature',
      fontSize: isMobile(context) ? fontSize - 10 : fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle navBarFont(
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: 'Gangors',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle sPrimaryFont(
    double fontSize,
    Color color,

    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: 'BodoniModa',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle primaryFont(
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle subFont(
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontFamily: 'Lato',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
