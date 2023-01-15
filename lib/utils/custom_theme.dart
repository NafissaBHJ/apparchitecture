import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  ThemeData _lightTheme = ThemeData.light();
  Color primary = const Color(0xFFFFFFFF);
  Color secondary = const Color(0xff0077b6);
  Color accent = const Color(0xFFcaf0f8);
  Color secondaryhint = Color.fromARGB(122, 0, 118, 182);
  return _lightTheme.copyWith(
      primaryColor: primary,
      scaffoldBackgroundColor: primary,
      hintColor: secondaryhint,
      highlightColor: accent,
      textTheme: TextTheme().copyWith(
        headline1: TextStyle(
            fontSize: 24, color: secondary, fontWeight: FontWeight.w600),
        headline2: TextStyle(fontSize: 16, color: secondaryhint),
        bodyText1: TextStyle(fontSize: 14, color: secondaryhint),
        bodyText2: TextStyle(fontSize: 14, color: primary),
      ),
      iconTheme: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accent),
      appBarTheme: AppBarTheme.of(context).copyWith(
          iconTheme: IconThemeData(color: secondary),
          backgroundColor: Colors.transparent,
          elevation: 0),
      drawerTheme: DrawerTheme.of(context).copyWith(
          backgroundColor: secondary,
          elevation: 0,
          scrimColor: Colors.transparent));
}
