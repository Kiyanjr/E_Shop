import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,

    primaryColor: Color(0xFFE0F7FA),

    hintColor: Color(0xFF00ACC1),

    scaffoldBackgroundColor: Colors.white,

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      buttonColor: Color(0xFF00ACC1),
      textTheme: ButtonTextTheme.primary,
    ),

    //icons
    iconTheme: IconThemeData(
      color: Color(0xFF00ACC1), //
      size: 24.0,
    ),

    // AppBar
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0, // بدون سایه
      iconTheme: IconThemeData(color: Color(0xFF374747)),
      titleTextStyle: TextStyle(
        color: Color(0xFF37474F),
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Color(0xFFECEFF1),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),

    splashColor: Color(0xFFB2EBF2),
    highlightColor: Color(0xFF80DEEA),
  );
}
