import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Calendar_Pages/calendar_body.dart';
import 'package:flutter_app/pages/Google_Classrom_Pages/google_classroom_body.dart';
import 'package:flutter_app/pages/Hives_Pages/addTasks.dart';
import 'package:flutter_app/pages/Hives_Pages/create_hive.dart';
import 'package:flutter_app/pages/Hives_Pages/hive_settings.dart';
import 'package:flutter_app/pages/Hives_Pages/hives_body.dart';
import 'package:flutter_app/pages/Home_Pages/home_body.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/settings.dart';
import 'package:flutter_app/pages/Summaries_Pages/summary.dart';
import 'package:flutter_app/pages/Summaries_Pages/tracking_body.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/profile.dart';
import 'package:flutter_app/widgets/secondary_navbar.dart';

class MainPage extends StatefulWidget {
  final NavigationPage initialPage;
  const MainPage({super.key, this.initialPage = NavigationPage.home});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NavigationPage _currentPage;
  late PageController _pageController;
  late GlobalKey<CurvedNavigationBarState> _bottomNavigationKey;
  NavigationPage _lastTab = NavigationPage.home;
  final mainPages = [
    NavigationPage.home,
    NavigationPage.tracking,
    NavigationPage.hives,
    NavigationPage.classroom,
    NavigationPage.calendar,
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
    _pageController = PageController(
      initialPage: _currentPage.isMainPage ? _currentPage.mainTabIndex : 0,
    );
    if (_currentPage.isMainPage) {
      _lastTab = mainPages[_currentPage.mainTabIndex];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNavigate(NavigationPage page) {
    _lastTab = _currentPage;
    setState(() {
      _currentPage = page;
      if (page.isMainPage) {
        _lastTab = mainPages[page.mainTabIndex];
        _pageController.jumpToPage(page.mainTabIndex);
      }
    });
  }

  Widget _buildNonMainPageBody() {
    switch (_currentPage) {
      case NavigationPage.recentChanges:
        return const RecentChangesBody();
      case NavigationPage.summary:
        return const SummaryBody();
      case NavigationPage.settings:
        return SettingsBody(onNavigate: _onNavigate);
      case NavigationPage.profile:
        return const ProfileBody();
      case NavigationPage.addTasks:
        return const AddTasksBody();
      case NavigationPage.createHive:
        return CreateHive(onNavigate: _onNavigate);
      case NavigationPage.hiveSettings:
        return const HiveSettings();
      default:
        return const SizedBox.shrink();
    }
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                                icon: const Icon(Icons.history_outlined,
                                    color: Colors.red),
                                onPressed: () =>
                                    _onNavigate(NavigationPage.recentChanges),
                              ),
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined,
                                    color: Colors.red),
                                onPressed: () =>
                                    _onNavigate(NavigationPage.summary),
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings_outlined,
                                    color: Colors.red),
                                onPressed: () =>
                                    _onNavigate(NavigationPage.settings),
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
                        leadingDistribution:
                            TextLeadingDistribution.proportional,
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
      body: Stack(
        children: [
          Offstage(
            offstage: !_currentPage.isMainPage,
            child: PageView(
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
          ),
          if (!_currentPage.isMainPage)
            Container(
              color: const Color.fromARGB(0, 255, 255,
                  255), // hides the PageView behind it... this should stop the error from lacking a pageview i think
              child: _buildNonMainPageBody(),
            ),
        ],
      ),
      bottomNavigationBar: _currentPage.isMainPage
          ? CurvedNavigationBar(
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
                _onNavigate(mainPages[index]);
              },
            )
          : SecondaryNavBar(
              onBack: () => _onNavigate(_lastTab),
              onHome: () => _onNavigate(NavigationPage.home),
              onHives: () => _onNavigate(NavigationPage.hives),
            ),
    );
  }
}
