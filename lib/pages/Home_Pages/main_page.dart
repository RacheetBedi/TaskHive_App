import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
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
  final NavigationPage initialPage;
  MainPage({super.key, this.initialPage = NavigationPage.home});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NavigationPage _currentPage;
  final PageController _pageController = PageController();
  late GlobalKey<CurvedNavigationBarState> _bottomNavigationKey;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
    if (_currentPage.isMainPage) {
      _pageController.jumpToPage(_currentPage.mainTabIndex);
    }
  }

  void _onNavigate(NavigationPage page) {
    if (page.isMainPage) {
      _pageController.animateToPage(
        page.mainTabIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    setState(() {
      _currentPage = page;
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
                                icon: Icon(
                                  Icons.history_outlined,
                                  color: _currentPage == NavigationPage.recentChanges
                                      ? Colors.black
                                      : Colors.red,
                                ),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.to(() => MainPage(initialPage: NavigationPage.recentChanges));
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.analytics_outlined,
                                  color: _currentPage == NavigationPage.summary
                                      ? Colors.black
                                      : Colors.red,
                                ),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.to(() => MainPage(initialPage: NavigationPage.summary));
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: _currentPage == NavigationPage.settings
                                      ? Colors.black
                                      : Colors.red,
                                ),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {
                                  Get.to(() => MainPage(initialPage: NavigationPage.settings));
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
                      _currentPage.title,
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
        index: _currentPage.mainTabIndex,
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
          final pages = [
            NavigationPage.home,
            NavigationPage.tracking,
            NavigationPage.hives,
            NavigationPage.classroom,
            NavigationPage.calendar,
          ];
          _onNavigate(pages[index]);
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}