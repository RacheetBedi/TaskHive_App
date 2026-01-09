import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

final ThemeData appTheme = ThemeData(
    //Main Colorings
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
      ),
    ),
    primaryColor: const Color(0xFFFFDD97),
    canvasColor: const Color(0xFFFFDD97),
    scaffoldBackgroundColor: const Color(0xFFFFDD97),
    dividerColor: const Color(0xFF000000),

    //App Bar Themes
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xFFFFC95C),
      foregroundColor: Colors.black,
      elevation: 10,
      shadowColor: Color(0xFFFFDD97),
      iconTheme: IconThemeData(color: Colors.red),
      actionsIconTheme: IconThemeData(color: Colors.red),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 80,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jomhuria',
      ),
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xFFFFC95C),
      elevation: 10,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      shadowColor: Color(0xFFFFDD97),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(186, 255, 201, 92),
      selectedItemColor: Color.fromARGB(255, 0, 0, 0),
      unselectedItemColor: Color(0xFF000000),
      elevation: 10,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF000000),
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 0, 0, 0),
        size: 30,
      ),
      selectedLabelStyle: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Inter',
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFF000000),
        fontFamily: 'Inter',
        fontSize: 14,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
    ),


    //Popups Themes
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFFFB743),
      contentTextStyle: TextStyle(
        foreground: Paint()
          ..strokeWidth = 1
          ..color = const Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Inter',
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFFFFB743),
      titleTextStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30, fontFamily: 'Jomhuria', fontWeight: FontWeight.normal),
      contentTextStyle: const TextStyle(color: Color.fromARGB(179, 66, 66, 66)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFFFFB743),
      textStyle: const TextStyle(color: Colors.white),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFFFB743),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    badgeTheme: const BadgeThemeData(
      backgroundColor: Color(0xFFFF6A00),
      textColor: Color.fromARGB(255, 0, 0, 0),
      padding: EdgeInsets.all(6),
    ),
    
    //Buttons/Inputs Themes
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(20),
      borderColor: const Color.fromARGB(255, 0, 0, 0),
      selectedColor: const Color(0xFFFF6A00),
      fillColor: const Color(0xFFFFF600),
      textStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color.fromARGB(255, 255, 94, 0);
      }
      return const Color.fromARGB(255, 255, 94, 0);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color.fromARGB(255, 255, 157, 0);
      }
      return const Color.fromARGB(255, 139, 93, 0);
      }),
      trackOutlineColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
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
          fontFamily: 'Inter',
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
      fillColor: Colors.white,
      hintStyle: const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontFamily: 'Inter',
      fontSize: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.black, width: 4),
      ),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: const Color(0xFFFFB743),
      headerBackgroundColor: const Color(0xFFEA9610),
      headerForegroundColor: const Color(0xFF000000),
      dividerColor: const Color(0xFF000000),
      dayForegroundColor: WidgetStateProperty.all(const Color(0xFF000000)),
      todayForegroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
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
      dialTextColor: Colors.black,
      hourMinuteColor: const Color(0xFFFF8800),
      dayPeriodColor: const Color(0xFFFF8800),
      entryModeIconColor: const Color(0xFF000000),
      hourMinuteShape: const CircleBorder(
        side: BorderSide(color: Color(0xFF000000), width: 2),
      ),
      dayPeriodShape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF000000), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      confirmButtonStyle: TextButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color.fromARGB(255, 0, 255, 13),
      ),
      elevation: 15,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 147, 24)),
      checkColor: WidgetStateProperty.all(const Color(0xFFFFF600)),
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
      disabledColor: const Color.fromARGB(255, 148, 106, 38),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFB743),
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: 'Inter',
          fontSize: 20,
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
    ),
);