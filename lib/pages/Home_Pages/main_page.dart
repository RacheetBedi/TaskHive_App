import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Calendar_Pages/calendar_body.dart';
import 'package:flutter_app/pages/Google_Classrom_Pages/google_classroom_body.dart';
import 'package:flutter_app/pages/Hives_Pages/hives_body.dart';
import 'package:flutter_app/pages/Home_Pages/home_body.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/settings.dart';
import 'package:flutter_app/pages/Summaries_Pages/summary.dart';
import 'package:flutter_app/pages/Summaries_Pages/tracking_body.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MainPage extends StatefulWidget {
  int CurIndex = 0;
  MainPage({super.key, required int CurIndex});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;
  final PageController _pageController = PageController();
  late GlobalKey<CurvedNavigationBarState> _bottomNavigationKey;

  final List<String> _titles = ["Home", "Tracking", "Hives", "Classroom", "Calendar"];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.CurIndex;
    _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  }

  void _onNavigate(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    setState(() {
      _currentIndex = index;
    });
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
                                  Get.to(() => const RecentChanges());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.to(() => const Summary());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.to(() => const Settings());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      _titles[_currentIndex],
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                        leadingDistribution: TextLeadingDistribution.proportional,
                      ),
                      style: const TextStyle(
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeBody(onNavigate: _onNavigate),
          TrackingBody(onNavigate: _onNavigate),
          HivesBody(onNavigate: _onNavigate),
          GoogleClassroomBody(onNavigate: _onNavigate),
          CalendarBody(onNavigate: _onNavigate),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentIndex,
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.screen_search_desktop_outlined, size: 30),
          Icon(Icons.groups_outlined, size: 30),
          Icon(Icons.co_present_outlined, size: 30),
          Icon(Icons.calendar_month_outlined, size: 30),
        ],
        color: const Color.fromARGB(255, 243, 139, 21),
        buttonBackgroundColor: const Color.fromARGB(255, 230, 123, 96),
        backgroundColor: const Color(0xFFFFDD97),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
          setState(() {
            _currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}