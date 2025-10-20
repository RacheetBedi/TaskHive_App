import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    fontFamily: 'Jomhuria-Bold',
    primaryColor: const Color(0xFFFFDD97),
    scaffoldBackgroundColor: const Color(0xFFFFDD97),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(300, 50),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        textStyle: const TextStyle(
          fontSize: 22,
          fontFamily: 'Inter_18pt-Regular',
        ),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color.fromARGB(174, 255, 241, 176),
      titleTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
      contentTextStyle: const TextStyle(color: Color.fromARGB(179, 66, 66, 66)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(
        color: Color(0xFF828282),
        fontFamily: 'Inter_18pt-Regular',
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
    ),
);