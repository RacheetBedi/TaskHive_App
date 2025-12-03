import 'dart:ui';

import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/role.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SignupTeacher extends ConsumerStatefulWidget {
  const SignupTeacher({super.key});

  @override
  ConsumerState<SignupTeacher> createState() => _SignupTeacherState();
}

class _SignupTeacherState extends ConsumerState<SignupTeacher> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController school = TextEditingController();
  final FancyPasswordController _password = FancyPasswordController();

  bool _isEmailFieldEnabled = true;
  bool _isFirstNameFieldEnabled = true;
  bool _isLastNameFieldEnabled = true;
  bool _isUsernameFieldEnabled = true;
  bool _isPasswordFieldEnabled = true;
  bool _isReEnterPasswordFieldEnabled = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    super.initState();
    callPopulate();
  }

  populate() async{
    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    final isGoogleSignIn = await authNotifier.checkGoogleSignIn();

    if(isGoogleSignIn){
      setState(() {
        AppUser currentUser = authState.asData?.value as AppUser;
        String storedEmail = currentUser?.email ?? '';
        String storedFirstName = currentUser?.displayFirstName ?? '';
        String storedLastName = currentUser?.displayLastName ?? '';
        String storedUsername = currentUser?.userName ?? '';

        if(storedEmail != ''){
          email.text = storedEmail;
          _isEmailFieldEnabled = false;
        }

        if(storedFirstName != ''){
          first_name.text = storedFirstName;
          _isFirstNameFieldEnabled = false;
        }

        if(storedLastName != ''){
          last_name.text = storedLastName;
          _isLastNameFieldEnabled = false;
        }

        if(storedUsername != ''){
          username.text = storedUsername;
          _isUsernameFieldEnabled  = false;
        }
      });
    }
  }

  void callPopulate(){
    populate();
  }

  @override
  void dispose() {
    email.dispose();
    first_name.dispose();
    last_name.dispose();
    username.dispose();
    _password.dispose();
    password2.dispose();
    super.dispose();
  }

  final FocusNode focusNode = FocusNode();

  signUp() async{
    final authState = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    final isGoogleSignIn = await authNotifier.checkGoogleSignIn();

    try{
      if(!isGoogleSignIn){
        await authNotifier.createFirebaseAccount(email.text, password.text);
      }

      final currentUser = UserRepository(ref);
      await currentUser.createTeacherUserDocIfNeeded(email.text, username.text, first_name.text, last_name.text, password.text, true, school.text);

      //authState.asData!.value!.hasCompletedSetup = true;
      Get.offAll(() => const Wrapper());
    } on FirebaseAuthException catch(e){
        Get.snackbar(
          "Error",
          "Unexpected Firebase Sign-In Error: ${e.toString()}",
          duration: const Duration(seconds: 10),
        );
    } on GoogleSignInException catch(e){
        Get.snackbar(
          "Error",
          "Unexpected Google Sign-In Error: ${e.toString()}",
          duration: const Duration(seconds: 10),
        );
    } catch (e){
        Get.snackbar(
          "Error",
          "Unexpected User Sign-In Error: ${e.toString()}",
          duration: const Duration(seconds: 10),
        );
    }
  }

  Future<bool> checkGoogleSignIn() async{
    final authNotifier = ref.read(authProvider.notifier);
    final isGoogleSignIn = await authNotifier.checkGoogleSignIn();
    return isGoogleSignIn;
  }

  final String pdlApiKey = 'ed8540c975fb8e6345d1ef14611b8e09c56b7fd3ce0e3c6ad701a593003665aa';
  Map<String, dynamic>? _selectedSchool;

  Future<List<Map<String, dynamic>>> getSchools(String query) async{
    if(query.length <2){
      return [];
    }

    final url = 'https://api.peopledatalabs.com/v5/autocomplete?api_key=$pdlApiKey&field=school&text=$query&size=10&titlecase=true';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (data.containsKey('data') && data['data'] is List) {
        final List<dynamic> results = data['data'];
        return results.cast<Map<String, dynamic>>();
      } else {
        Get.snackbar(
        'Unexpected API response format', 
        '$data',
      );
        return [];
      }
    } else{
      Get.snackbar(
        'Fetching Schools Error', 
        'The following error has occurred: ${response.statusCode} ${response.body}',
      );
      return [];
    }
  }

  signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(Wrapper());
  }

  @override
  Widget build(BuildContext context) {

    populate();
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    children:[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SafeArea(
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              Get.to(() => const Role());
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 15,),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 255, 255, 255),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/Oval Logo.png",
                                  height: 125,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            const Text(
                              'Create your teacher account', 
                              style: TextStyle(
                                fontSize: 50, 
                                fontFamily: 'Jomhuria'
                              ),
                            ),
                            const SizedBox(height: 15,),
                            TextField(
                              controller: email,
                              decoration: const InputDecoration(hintText: 'email@domain.com'),
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                              controller: username,
                              decoration: const InputDecoration(hintText: 'username'),
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                              controller: first_name,
                              decoration: const InputDecoration(hintText: 'first name'),
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                              controller: last_name,
                              decoration: const InputDecoration(hintText: 'last name'),
                            ),
                            const SizedBox(height: 10,),
                            TypeAheadField<Map<String, dynamic>>(
                              controller: school,
                              builder: (context, controller, focusNode){
                                return TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(hintText: 'school name'),
                                  focusNode: focusNode,
                                  autofocus: false,
                                );
                              },
                              itemBuilder: (context, suggestion){
                                return ListTile(
                                  title: Text(suggestion['name'] ?? ''),
                                  subtitle: Text(suggestion['meta']?['location_name'] ?? ''),
                                );
                              }, 
                              onSelected: (suggestion){
                                setState(() {
                                  school.text = suggestion['name'] ?? '';
                                  _selectedSchool = suggestion;
                                });

                                //print('Selected school: ${_selectedSchool!}');
                              }, 
                              debounceDuration: const Duration(milliseconds: 300),
                              emptyBuilder: (context){
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No schools found'),
                                );
                              },
                              errorBuilder: (context, error) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Error: ${error.toString()}'),
                                );
                              },
                              loadingBuilder: (context){
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Loading Schools'),
                                );
                              },
                              suggestionsCallback: (pattern) async{
                                try{
                                return await getSchools(pattern);
                                } catch(e){
                                    Get.snackbar(
                                    "Error",
                                    "User repository connection error: ${e.toString()}",
                                    duration: const Duration(seconds: 10),
                                  );
                                  return [];
                                }
                                },
                              ),
                            const SizedBox(height: 10,),
                            // TextField(
                            //   controller: password,
                            //   decoration: const InputDecoration(hintText: 'password'),
                            // ),
                            FancyPasswordField(
                              passwordController: _password,
                              hasStrengthIndicator: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              validationRules: {
                                DigitValidationRule(),
                                UppercaseValidationRule(),
                                LowercaseValidationRule(),
                                SpecialCharacterValidationRule(),
                                MinCharactersValidationRule(6),
                              },
                              onChanged: (value){
                                password.text = value;
                                setState(() {
                                });
                              },
                            ),
                            const Text(
                              "Your password must have:\n"
                              "Minimum 6 Length\n"
                              "1 Uppercase Letter\n"
                              "1 Lowercase Letter\n"
                              "1 Numerical digit \n"
                              "1 Non-Numerical Special Character"
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: password2,
                              obscureText: _obscureText2,
                              decoration: InputDecoration(
                                hintText: 'Re-enter Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _obscureText2 ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                )
                              ),
                              onChanged: (value){
                                setState(() {
                                });
                              },
                            ),
                            const SizedBox(height: 10,),
                            PasswordCheck(password: password.text, password2: password2.text),
                            const SizedBox(height: 10,),
                            ElevatedButton(
                              onPressed: (() async{

                                if(password.text != password2.text){
                                  Get.snackbar("Error", "Passwords do not match");
                                  return;
                                }
                                else if(!_password.areAllRulesValidated){
                                  Get.snackbar("Error", "Password missing requirements");
                                  return;
                                }
                                else{
                                  await signUp();
                                 }
                              }),
                              child: const Text("Sign Up"),
                            ),
                            const SizedBox(height: 20,),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 100, 149, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 6),
                                ),
                                maximumSize: const Size(300, 100),
                                minimumSize: const Size(300, 100),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/Teacher.png"),
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Teacher",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 245, 255, 101), 
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

class PasswordCheck extends StatelessWidget{

     String password;
     String password2;

    PasswordCheck({super.key, required this.password, required this.password2});

    @override
    Widget build(BuildContext context){
      return Row(
              children: [
                Icon(
                  password == password2 && password2.isNotEmpty
                  ? Icons.check_circle
                  : Icons.cancel,
                  color: password.toString() == password2 && password2.isNotEmpty
                  ? Colors.green
                  : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 8,),
                Text(
                  password.toString() == password2 && password2.isNotEmpty
                  ? "Passwords match"
                  : "Passwords do not match",
                  style: TextStyle(
                    color: password.toString() == password2 && password2.isNotEmpty
                    ? Colors.green
                    : Colors.red,
                  ),
                ),
              ],
            );
    }
}