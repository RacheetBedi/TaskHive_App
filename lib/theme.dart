import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
    fontFamily: 'JosefinSlab-Bold',
    primaryColor: const Color(0xFFFFDD97),
    scaffoldBackgroundColor: const Color(0xFFFFDD97),
    elevatedButtonTheme: ElevatedButtonThemeData(
      
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'JosefinSlab-light',
        ),
      ),
    ),
);