import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:flutter_app/pages/tracking.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_app/widgets/normal_task_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _isUserInitialized = false;

   Future<bool> checkLoggedIn() async{
    final authNotifier = ref.read(authProvider);
    if(authNotifier.asData?.value?.email == ''){
      return false;
    }
    else{
      return true;
    }
   }


  Future<AppUser?> initializeUser() async{
    //add a try-catch statement here.
    if(await checkLoggedIn() == true){
      Get.snackbar("Note", "Initializing User Data...");
      final user = await UserRepository(ref).initializeAppuser();
      _isUserInitialized = true;
      return user;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (!_isUserInitialized) {
      return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

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
                      "Home",
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
          if (index == 1) {
            Get.offAll(() => const Tracking());
          }
          else if (index == 2) {
            //Navigate to Hives Page
          }
          else if (index == 3) {
            //Navigate to Classroom Page
          }
          else if (index == 4) {
            //Navigate to Calendar Page
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
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
              return Center(
                child: Column(
                  children: [
                    const NormalTaskWidget(
                      title: "My Tasks",
                      tasks: [
                        {
                          'name': 'Complete Math Homework',
                          'description': 'Finish chapter 5 exercises',
                        },
                        {
                          'name': 'Read Science Chapter',
                          'description': 'Read pages 45-67',
                        },
                        {
                          'name': 'Write Essay',
                          'description': '500-word essay on climate change',
                        },
                        {
                          'name': 'Study for Test',
                          'description': 'Review biology notes',
                        },
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const Tracking());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100000000),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.track_changes, size: 30, color: Color(0xFFFF7F6E),),
                          SizedBox(width: 10),
                          Text(
                            "Assignment Progress",
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 40,
                              color: Color(0xFFFF7F6E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Google Classroom Widget
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {}, //Take us to Hives Page
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100000000),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.groups, size: 30, color: Color(0xFFFF0000),),
                          SizedBox(width: 10),
                          Text(
                            "My Hives",
                            style: TextStyle(
                              fontFamily: 'Jomhuria',
                              fontSize: 40,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Nectar Center Widget
                    //Recent Updates Widget
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