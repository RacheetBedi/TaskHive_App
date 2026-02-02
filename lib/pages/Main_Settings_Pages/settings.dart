import 'dart:collection';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Hives_Pages/addTasks.dart';
import 'package:flutter_app/pages/Home_Pages/main_page.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/profile.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/pages/Setup_Pages/signupTeacher.dart';
import 'package:flutter_app/pages/Home_Pages/home_body.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBody extends ConsumerStatefulWidget {
  final Function(NavigationPage)? onNavigate;
  const SettingsBody({super.key, this.onNavigate});
  @override
  ConsumerState<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends ConsumerState<SettingsBody> {
  bool _darkMode = false;
  String _language = "English";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String userFullName = "";
  bool _isNameValid = false;

  logOut() async{
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    authNotifier.signOut();
    Get.offAll(() => const Wrapper());
  }
  
  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse('https://www.example.com');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }


    deleteAccountPopup() async {
      final authNotifier = ref.read(authProvider.notifier);
      final authState = ref.watch(authProvider);
      final curUser = UserRepository(ref).currentAppUser;
      if(authState != null && authState.asData !=null && authState.asData!.value != null){
        userFullName = authState.asData!.value!.userName ?? "";
      }
      final result = await showDialog<bool>(
        context: context, 
        builder: (context){ 
          return StatefulBuilder(
          builder: (context, setState){
          return AlertDialog(
          title: const Text("NOTE: You are about to delete your account. This action cannot be undone."),
          content: const Text("Are you sure you desire to proceed? Enter your full userName below to confirm."),
          actions: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
              onChanged: (value){
                setState(() {
                  if(value.trim() == curUser?.userName){
                    _isNameValid = true;
                  }
                  else{
                    _isNameValid = false;
                  }
                  Get.snackbar("Trimmed value:", "$_isNameValid");
                });
              },
            ),
            ElevatedButton(
              
              onPressed: _isNameValid ? (){
                Navigator.pop(context, true);
              } : null,
              
              child: const Text(
                "Delete Account",
                style: TextStyle(color: Colors.red)),
            ),
          ]
        );
          },
          );
        }
      );
      if (result == true){
        try{
          final currentUser = UserRepository(ref);

          await currentUser.currentUserDocument.delete();

          await FirebaseAuth.instance.currentUser?.delete();
        } on FirebaseAuthException catch (e){
          if(e.code == 'requires-recent-login'){
            Get.snackbar(
              'ATTENTION:',
              'Sign in is stale. Please log out and sign back in again to delete account. Thank you.' 
            );
          } else{
            Get.snackbar(
              'ATTENTION:',
              'The following error has occurred: ${e.toString()}'
            );
          }
        } catch (e){
          Get.snackbar(
            'ATTENTION:',
            'An unexpected error occurred: ${e.toString()}' 
          );
        }
        Get.to(() => const LoginPage());
      }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
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
                      'Dark Mode',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _darkMode,
                      onChanged: (val) => setState(() => _darkMode = val),
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
                      'Language',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1,
                      child: DropdownMenu<LanguageLabel>(
                        initialSelection: LanguageLabel.english,
                        onSelected: (LanguageLabel? language) {
                          setState(() {
                            _language = language?.label ?? "English";
                          });
                        },
                        dropdownMenuEntries: LanguageLabel.entries,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                padding: EdgeInsets.zero,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                maximumSize: const Size(double.infinity, double.infinity),
              ),
              onPressed: () {
                widget.onNavigate!(NavigationPage.profile);
              },
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color:Color.fromARGB(115, 0, 0, 0),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 6.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Jomhuria',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                padding: EdgeInsets.zero,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                maximumSize: const Size(double.infinity, double.infinity),
                 
              ), 
              onPressed: () {
                Dialog contactUsDialog = Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'Jomhuria',
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(icon: const Icon(Icons.email_outlined), color: const Color(0xFFFF7474), onPressed: () {}),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Email: taskhive@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                // foreground: Paint()
                                // ..style = PaintingStyle.stroke
                                // ..strokeWidth = .2
                                // ..color = Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(icon: const Icon(Icons.phone_outlined), color: const Color(0xFF58FF42), onPressed: () {}),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Phone: +1 234 567 8901',
                              style: TextStyle(
                                color: Colors.black,
                                // foreground: Paint()
                                // ..style = PaintingStyle.stroke
                                // ..strokeWidth = .2
                                // ..color = Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.web_outlined), 
                              color: const Color.fromARGB(255, 66, 227, 255), 
                              onPressed: _launchWebsite,
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Website: www.taskhive.com',
                              style: TextStyle(
                                color:Colors.black,
                                // foreground: Paint()
                                // ..style = PaintingStyle.stroke
                                // ..strokeWidth = .2
                                // ..color = Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return contactUsDialog;
                  },
                );
              }, //Contact us popup
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color:Color.fromARGB(115, 0, 0, 0),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 6.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Jomhuria',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(115, 0, 0, 0),
                padding: EdgeInsets.zero,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                maximumSize: const Size(double.infinity, double.infinity),
              ),
              onPressed: () => logOut(),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color:Color.fromARGB(115, 0, 0, 0),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 6.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 0, 0),
                          fontSize: 48,
                          fontFamily: 'Jomhuria',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(115, 0, 0, 0),
                padding: EdgeInsets.zero,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                maximumSize: const Size(double.infinity, double.infinity),
              ),
              onPressed: () async{ 
                Get.snackbar("Popup clicked", "Delete account button was clicked");
                await deleteAccountPopup();
              }, //Delete Account
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color:Color.fromARGB(115, 0, 0, 0),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 6.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DELETE ACCOUNT',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 0, 0),
                          fontSize: 48,
                          fontFamily: 'Jomhuria',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                widget.onNavigate!(NavigationPage.addTasks);
              },
              child: const Text("Temp: To Add Tasks"),
            ),
          ],
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
