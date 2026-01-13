import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/calendar.dart';
import 'package:flutter_app/pages/google_classroom.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/recent_changes.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/pages/Setup_Pages/signupTeacher.dart';
import 'package:flutter_app/pages/specificHive.dart';
import 'package:flutter_app/pages/summary.dart';
import 'package:flutter_app/pages/tracking.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_app/widgets/hive_widget.dart';
import 'package:flutter_app/widgets/nectar_center_points_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Hives extends ConsumerStatefulWidget {
  const Hives({super.key});
  @override
  ConsumerState<Hives> createState() => _HivesState();
}

class _HivesState extends ConsumerState<Hives> {

  List<HiveWidget> userHives = [
    const HiveWidget(hiveColor: Colors.blue, hiveIcon: Icon(Icons.travel_explore), hiveName: "Hive 1", hivePage: SpecificHive(hiveColor: Colors.blue, hiveIcon: Icon(Icons.travel_explore), hiveName: "Hive 1")),
    const HiveWidget(hiveColor: Colors.green, hiveIcon: Icon(Icons.access_alarm), hiveName: "Hive 2", hivePage: SpecificHive(hiveColor: Colors.green, hiveIcon: Icon(Icons.access_alarm), hiveName: "Hive 2")),
    const HiveWidget(hiveColor: Colors.pink, hiveIcon: Icon(Icons.engineering), hiveName: "Hive 3", hivePage: SpecificHive(hiveColor: Colors.pink, hiveIcon: Icon(Icons.engineering), hiveName: "Hive 3")),
    const HiveWidget(hiveColor: Colors.orange, hiveIcon: Icon(Icons.bike_scooter), hiveName: "Hive 4", hivePage: SpecificHive(hiveColor: Colors.orange, hiveIcon: Icon(Icons.bike_scooter), hiveName: "Hive 4")),
  ];
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
                                icon: const Icon(Icons.history_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.offAll(() => const RecentChanges());
                                },
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
                      "Hives",
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
            icon: Icon(Icons.groups),
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
              return Center(
                child: Column(
                  children: [ 
                    const NectarCenterPointsWidget(),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        //join hive functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(180, 70),
                        maximumSize: const Size(250, 75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 30, color: Color(0xFFFF0000),),
                          SizedBox(width: 10),
                          Text(
                            "Join Hive",
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 40,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        //Create Hive functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(180, 70),
                        maximumSize: const Size(250, 75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group_add_outlined, size: 30, color: Color(0xFFFF0000),),
                          SizedBox(width: 10),
                          Text(
                            "Create Hive",
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 40,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      "My Hives",
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    ),
                    ...userHives.expand((widget) => [widget, const SizedBox(height: 5)]).toList()..removeLast(),
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