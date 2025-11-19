import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AddTasks extends ConsumerStatefulWidget {
  const AddTasks({super.key});
  @override
  ConsumerState<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends ConsumerState<AddTasks> {
  String _Hive = "Hive 1";
  String _Difficulty = "Easy Task";
  String _TaskOwner = "Task Owner";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Circle Logo.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(104, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.history_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () => Get.offAll(() => const Settings()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Positioned(
                  top: 64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Add Tasks",
                      textHeightBehavior: TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                        leadingDistribution: TextLeadingDistribution.proportional,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 80,
                        height: 0.65,
                        fontFamily: 'Jomhuria',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const Home());
          }
          
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.screen_search_desktop_outlined),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Hives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.co_present_outlined),
            label: 'Classroom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Transform.scale(
                scale: 1,
                child: DropdownMenu<HiveLabel>(
                  initialSelection: HiveLabel.hive1,
                  onSelected: (HiveLabel? hive) {
                    setState(() {
                      _Hive = hive?.label ?? "Hive 1";
                    });
                  },
                  dropdownMenuEntries: HiveLabel.entries,
                ),
              ),
              Transform.scale(
                scale: 1,
                child: DropdownMenu<DifficultyLabel>(
                  initialSelection: DifficultyLabel.easy,
                  onSelected: (DifficultyLabel? difficulty) {
                    setState(() {
                      _Hive = difficulty?.label ?? "Easy Task";
                    });
                  },
                  dropdownMenuEntries: DifficultyLabel.entries,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

typedef DifficultyEntry = DropdownMenuEntry<DifficultyLabel>;

enum DifficultyLabel {
  easy('Easy Task'),
  medium('Medium Task'),
  hard('Hard Task');

  const DifficultyLabel(this.label);
  final String label;

  static final List<DropdownMenuEntry<DifficultyLabel>> entries =
      DifficultyLabel.values.map((difficulty) {
    return DropdownMenuEntry<DifficultyLabel>(
      value: difficulty,
      label: difficulty.label,
    );
  }).toList();
}

typedef HiveEntry = DropdownMenuEntry<HiveLabel>;

enum HiveLabel {
  hive1('Hive 1'),
  hive2('Hive 2'),
  hive3('Hive 3');

  const HiveLabel(this.label);
  final String label;

  static final List<DropdownMenuEntry<HiveLabel>> entries =
      HiveLabel.values.map((hive) {
    return DropdownMenuEntry<HiveLabel>(
      value: hive,
      label: hive.label,
    );
  }).toList();
}