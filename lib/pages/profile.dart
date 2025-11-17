import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password2 = TextEditingController();

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
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      onPressed: () {
                        Get.to(() => const Settings());
                      },
                    ),
                    ),
                ),
                const Positioned(
                  top: 64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Profile",
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
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Hive Background.png"),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'First Name',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    TextField(
                      controller: firstName,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        constraints: BoxConstraints(
                          maxWidth: 225,
                          minWidth: 50,
                          minHeight: 50,
                          maxHeight: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Last Name',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    TextField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        constraints: BoxConstraints(
                          maxWidth: 225,
                          minWidth: 50,
                          minHeight: 50,
                          maxHeight: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Username',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        constraints: BoxConstraints(
                          maxWidth: 225,
                          minWidth: 50,
                          minHeight: 50,
                          maxHeight: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Profile Picture',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Image.asset('assets/images/TempUserPFP.png'),
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

typedef LanguageEntry = DropdownMenuEntry<LanguageLabel>;

enum LanguageLabel {
  english('English'),
  spanish('Spanish'),
  french('French'),
  german('German'),
  italian('Italian'),
  dutch('Dutch');

  const LanguageLabel(this.label);
  final String label;

  static final List<DropdownMenuEntry<LanguageLabel>> entries =
      LanguageLabel.values.map((language) {
    return DropdownMenuEntry<LanguageLabel>(
      value: language,
      label: language.label,
    );
  }).toList();
}
