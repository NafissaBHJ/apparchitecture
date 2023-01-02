import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  ThemeData _lightTheme = ThemeData.light();
  Color primary =  const Color(0xffDAD7CD);
  return _lightTheme.copyWith(
    primaryColor: primary
  );
}
