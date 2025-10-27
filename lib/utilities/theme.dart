import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

final ThemeData appTheme = ThemeData(
    //Main Colorings
    fontFamily: 'Jomhuria',
    primaryColor: const Color(0xFFFFDD97),
    canvasColor: const Color(0xFFFFDD97),
    scaffoldBackgroundColor: const Color(0xFFFFDD97),
    dividerColor: const Color(0xFF000000),


    //AppBar Themes
    appBarTheme: const AppBarThemeData(
      backgroundColor: Color(0xFFFFC95C),
      foregroundColor: Color(0xFF000000),
      shadowColor: Color(0xFFFFDD97),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF000000),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFF000000),
      ),
      elevation: 8,
      scrolledUnderElevation: 0,
      toolbarTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 16,
        fontFamily: 'Jomhuria',
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 20,
        fontFamily: 'Jomhuria',
      ),
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFFFFC95C),
      elevation: 8,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      shadowColor: Color(0xFFFFDD97),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(186, 255, 201, 92),
      selectedItemColor: Color(0xFFFF6A00),
      unselectedItemColor: Color(0xFF000000),
      elevation: 8,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF000000),
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFFFF6A00),
        size: 30,
      ),
      selectedLabelStyle: TextStyle(
        color: Color(0xFFFF6A00),
        fontFamily: 'Inter_18pt',
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFF000000),
        fontFamily: 'Inter_18pt',
        fontSize: 14,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),


    //Popups Themes
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.transparent,
      contentTextStyle: TextStyle(
        foreground: Paint()
          ..strokeWidth = 1
          ..color = const Color.fromARGB(255, 255, 0, 0),
        fontFamily: 'Inter_18pt',
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color.fromARGB(174, 255, 241, 176),
      titleTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
      contentTextStyle: const TextStyle(color: Color.fromARGB(179, 66, 66, 66)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFFFFB743),
      textStyle: const TextStyle(color: Colors.white),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    ),

    badgeTheme: const BadgeThemeData(
      backgroundColor: Color(0xFFFF6A00),
      textColor: Color.fromARGB(255, 0, 0, 0),
      padding: EdgeInsets.all(6),
    ),
    
    //Buttons/Inputs Themes
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(20),
      borderColor: const Color(0xFFFF0000),
      selectedColor: const Color(0xFFFF6A00),
      fillColor: const Color.fromARGB(158, 255, 247, 0),
      textStyle: const TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: 16,
      ),
    ),

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

    inputDecorationTheme: InputDecorationTheme(
      constraints: const BoxConstraints(
        maxWidth: 400,
        minWidth: 300,
        minHeight: 50,
        maxHeight: 50,
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 253, 126),
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Inter_18pt',
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

    datePickerTheme: DatePickerThemeData(
      backgroundColor: const Color(0xFFFFB743),
      headerBackgroundColor: const Color(0xFFEA9610),
      headerForegroundColor: const Color(0xFF000000),
      dividerColor: const Color(0xFF000000),
      dayForegroundColor: WidgetStateProperty.all(const Color(0xFF000000)),
      todayForegroundColor: WidgetStateProperty.all(const Color(0xFFFF6A00)),
      cancelButtonStyle: TextButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      confirmButtonStyle: TextButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color.fromARGB(255, 0, 255, 13),
      ),
      todayBackgroundColor: WidgetStateProperty.all(const Color(0xFFFF8800)),
      elevation: 15,
    ),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: const Color(0xFFFFB743),
      hourMinuteTextColor: const Color(0xFF000000),
      dayPeriodTextColor: const Color(0xFF000000),
      dialBackgroundColor: const Color(0xFFEA9610),
      dialHandColor: const Color(0xFFFF6A00),
      entryModeIconColor: const Color(0xFF000000),
      hourMinuteShape: const CircleBorder(
        side: BorderSide(color: Color(0xFF000000), width: 2),
      ),
      dayPeriodShape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF000000), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 15,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 147, 24)),
      checkColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 230, 0)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFFFFB743)),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
);