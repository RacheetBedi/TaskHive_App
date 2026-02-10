import 'package:flutter/material.dart';

enum Achievements {
  extrovert,
  teachersPet,
  busyBee,
}

extension AchievementsExtension on Achievements {
  String get title {
    switch (this) {
      case Achievements.extrovert:
        return 'Extrovert';
      case Achievements.teachersPet:
        return 'Teacher\'s Pet';
      case Achievements.busyBee:
        return 'Busy Bee';
    }
  }

  int get points {
    switch (this) {
      case Achievements.extrovert:
        return 10;
      case Achievements.teachersPet:
        return 20;
      case Achievements.busyBee:
        return 100;
    }
  }

  String get description {
    switch (this) {
      case Achievements.extrovert:
        return 'Awarded for being a part of 4 or more hives.';
      case Achievements.teachersPet:
        return 'Earn a total of 500 nectar points from teachers.';
      case Achievements.busyBee:
        return 'Awarded for completing 20 or more tasks in a week.';
    }
  }

  String get icons{
    switch (this) {
      case Achievements.extrovert:
        return 'placeholder_1';
      case Achievements.teachersPet:
        return 'placeholder_2';
      case Achievements.busyBee:
        return 'placeholder_3';
    }
  }

  Color get foregroundColor {
    switch (this) {
      case Achievements.extrovert:
        return const Color(0xFFFF00F8);
      case Achievements.teachersPet:
        return const Color(0xFFFF9C2B);
      case Achievements.busyBee:
        return const Color(0xFFFF0000);
    }
  } //Icons, text, and description

  Color get backgroundColor {
    switch (this) {
      case Achievements.extrovert:
        return const Color(0xFF2B214E);
      case Achievements.teachersPet:
        return const Color(0xFFA21B1D);
      case Achievements.busyBee:
        return const Color.fromARGB(255, 250, 187, 128);
    }
  }

  //Add a get animations once we code the animations object
}
