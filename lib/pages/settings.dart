import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});
  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  bool _darkMode = false;
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
                                icon: const Icon(Icons.settings_outlined, color: Color.fromARGB(255, 0, 0, 0)),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
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
                      "Settings",
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Hive Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  top: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dark Mode:',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Switch(
                      value: _darkMode,
                      onChanged: (val) => setState(() => _darkMode = val),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}