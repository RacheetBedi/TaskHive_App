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
        minimumSize: const Size(350, 50),
        maximumSize: const Size(350, 50),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        textStyle: const TextStyle(
          fontSize: 18,
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

    // snackBarTheme: SnackBarThemeData(
    //   backgroundColor: Colors.transparent,
    //   contentTextStyle: TextStyle(
    //     foreground: Paint()
    //       ..strokeWidth = 1
    //       ..color = const Color.fromARGB(255, 255, 0, 0),
    //     fontFamily: 'Inter_18pt-Regular',
    //   ),
    //   behavior: SnackBarBehavior.floating,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
    
    inputDecorationTheme: InputDecorationTheme(
      constraints: const BoxConstraints(
        maxWidth: 400,
        minWidth: 300,
        minHeight: 50,
        maxHeight: 50,
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(
        color: Color(0xFF828282),
        fontFamily: 'Inter_18pt-Regular',
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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