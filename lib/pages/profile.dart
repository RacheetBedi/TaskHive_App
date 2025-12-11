import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/signupStudent.dart';
import 'package:flutter_app/pages/signupTeacher.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/tracking.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController description = TextEditingController();

  bool _isEmailEnabled = false;

  bool _firstNameChanged = false;
  bool _lastNameChanged = false;
  bool _usernameChanged = false;
  //add a profile picture changed option here
  bool _emailChanged = false;
  bool _phoneChanged = false;
  bool _descriptionChanged = false;

  @override
  void initState() {
    super.initState();
    checkGoogleSignIn().then((isGoogle) {
      setState(() {
        _isEmailEnabled = !isGoogle;
      });
    });
    populate();
  }

  File? _pickedImage;
  bool _isProfileEditEnabled = false;

    populate() async{
      final curUser = UserRepository(ref).currentAppUser;

      setState(() {
        String storedEmail = curUser?.email ?? '';
        String storedFirstName = curUser?.displayFirstName ?? '';
        String storedLastName = curUser?.displayLastName ?? '';
        String storedUsername = curUser?.userName ?? '';
        String storedPhone = curUser?.phoneNumber ?? '';
        String storedDescription = curUser?.description ?? '';
        if(storedEmail != ''){
          email.text = storedEmail;
        }

        if(storedFirstName != ''){
          firstName.text = storedFirstName;
        }

        if(storedLastName != ''){
          lastName.text = storedLastName;
        }

        if(storedUsername != ''){
          username.text = storedUsername;
        }

        if(storedPhone != ''){
          phone.text = storedPhone;
        }

        if(storedDescription != ''){
          description.text = storedDescription;
        }
      });
  }

  bool checkEmail(profileEdit, emailEnabled){
    if(profileEdit){
      if(emailEnabled){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }

  Future<bool> checkGoogleSignIn() async{
    final authNotifier = ref.read(authProvider.notifier);
    final isGoogleSignIn = await authNotifier.checkGoogleSignIn();
    return isGoogleSignIn;
  }

  Future<void> _pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path); 
      });
    }
  }

  Future<void> _saveProfile() async{
    final currentUser = UserRepository(ref);
    final userDoc = currentUser.currentUserDocument;
    setState(() {
      if(_isProfileEditEnabled == false){
        if(_firstNameChanged == true){
          currentUser.updateAppUser(displayFirstName: firstName.text);
        }
        if(_lastNameChanged == true){
          currentUser.updateAppUser(displayLastName: lastName.text);
        }
        if(_usernameChanged == true){
          currentUser.updateAppUser(userName: username.text);
        }
        if(_emailChanged == true){
          currentUser.updateAppUser(email: email.text);
        }
        if(_phoneChanged == true){
          currentUser.updateAppUser(phoneNumber: phone.text);
        }
        if(_descriptionChanged == true){
          currentUser.updateAppUser(description: description.text);
        }
        _firstNameChanged = false;
        _lastNameChanged = false;
        _usernameChanged = false;
        _emailChanged = false;
        _phoneChanged = false;
        _descriptionChanged = false;
      }
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
          else if (index == 1) {
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
        child: SingleChildScrollView(
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
                        enabled: _isProfileEditEnabled,
                        onChanged: (_){
                          setState(() {
                             _firstNameChanged = true;
                          });
                        },
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
                        enabled: _isProfileEditEnabled,
                        onChanged: (_){
                          setState(() {
                             _lastNameChanged = true;
                          });
                        },
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
                        enabled: _isProfileEditEnabled,
                        onChanged: (_){
                          setState(() {
                             _usernameChanged = true;
                          });
                        },
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
                      GestureDetector(
                        onTap: _pickImageFromCamera,
                        child: _pickedImage == null ? Image.asset("assets/images/TempUserPFP.png") : Image.asset(_pickedImage!.path)
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
                        'Email',
                        style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                      ),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: 'email@domain.com',
                          constraints: BoxConstraints(
                            maxWidth: 225,
                            minWidth: 50,
                            minHeight: 50,
                            maxHeight: 50,
                          ),
                        ),
                        enabled: checkEmail(_isProfileEditEnabled, _isEmailEnabled),
                        onChanged: (_){
                          setState(() {
                             _emailChanged = true;
                          });
                        },
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
                        'Phone #',
                        style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                      ),
                      TextField(
                        controller: phone,
                        decoration: const InputDecoration(
                          hintText: 'number',
                          constraints: BoxConstraints(
                            maxWidth: 225,
                            minWidth: 50,
                            minHeight: 50,
                            maxHeight: 50,
                          ),
                        ),
                        enabled: _isProfileEditEnabled,
                        onChanged: (_){
                          setState(() {
                             _phoneChanged = true;
                          });
                        },
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
                        'Description',
                        style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                      ),
                      TextField(
                        controller: description,
                        decoration: const InputDecoration(
                          hintText: 'description',
                          constraints: BoxConstraints(
                            maxWidth: 225,
                            minWidth: 50,
                            minHeight: 50,
                            maxHeight: 50,
                          ),
                        ),
                        enabled: _isProfileEditEnabled,
                        onChanged: (_){
                          setState(() {
                             _descriptionChanged = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isProfileEditEnabled = !_isProfileEditEnabled;
                  });
                  if(_isProfileEditEnabled == false){
                    await _saveProfile();
                  }
                }, //Should allow us to edit the fields
                child: _isProfileEditEnabled ? const Text("Save Changes") : const Text("Edit Profile"),
                //Add a discard changes button.
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  width: double.infinity,
                  height: 210,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(180, 0, 0, 0),
                    borderRadius: BorderRadius.circular(31.0),
                  ),
                  child: const Center(
                    child: Text(
                      'NOTE:\nOnly your name, contact information, description, and profile picture will appear on your public profile. Any other information entered will remain confidential and only accessible by you.',
                      style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: 'Inter'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
