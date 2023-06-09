import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  const CustomTheme();
  static const Color backgroundColor = Colors.white;
  static const Color pinkColor = Color(0xFFf7418c);
  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFf7418c);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color yellowClr = Color.fromARGB(255, 247, 189, 65);
  static const Color primaryClr = Color(0xFF4e5ae8);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
    )
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    )
  );
}

TextStyle get colorTileStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white
    )
  );
}
TextStyle get groupNameStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white
      
    )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400
      
    )
  );
}
TextStyle get subtitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400
    )
  );
}
TextStyle get subviewerText{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    )
  );
}

TextStyle get subTextstyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.grey
    )
  );
}
TextStyle get subUsernameText{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black54
    )
  );
}
  TextStyle get substyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white
    )
  );
}
TextStyle get headingProfileText{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,

    )
  );
}
TextStyle get subProfileText{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      //color: Colors.black54
    )
  );
}