import 'package:flutter/material.dart';
import 'package:flutter_app/pages/calendar.dart';
import 'package:flutter_app/pages/google_classroom.dart';
import 'package:flutter_app/pages/hives.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/summary.dart';
import 'package:flutter_app/pages/tracking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RecentChanges extends ConsumerStatefulWidget {
  const RecentChanges({super.key});
  @override
  ConsumerState<RecentChanges> createState() => _RecentChangesState();
}

class _RecentChangesState extends ConsumerState<RecentChanges> {

  @override
  void initState() {
    super.initState();
  }

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
                                icon: const Icon(Icons.history_outlined, color: Color.fromARGB(255, 0, 0, 0)),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.offAll(() => const Summary());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.offAll(() => const Settings());
                                },
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
                      "Recent Changes",
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
          else if (index == 1) {
            Get.offAll(() => const Tracking());
          }
          else if (index == 2) {
            Get.offAll(() => const Hives());
          }
          else if (index == 3) {
            Get.offAll(() => const GoogleClassroom());
          }
          else if (index == 4) {
            Get.offAll(() => const Calendar());
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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Scrollable(
            viewportBuilder: (context, position) {
              return const Center(
                child: Column(
                  children: [
                    //Future Widgets will go here
                  ],
                ),
              );
            },
          ),
        ),
      )
    );
  }
}