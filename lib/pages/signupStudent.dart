import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/role.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupStudent extends ConsumerStatefulWidget {
  const SignupStudent({super.key});

  @override
  ConsumerState<SignupStudent> createState() => _SignupStudentState();
}

class _SignupStudentState extends ConsumerState<SignupStudent> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController password2 = TextEditingController();

  bool _isEmailFieldEnabled = true;
  bool _isFirstNameFieldEnabled = true;
  bool _isLastNameFieldEnabled = true;
  bool _isUsernameFieldEnabled = true;
  bool _isPasswordFieldEnabled = true;
  bool _isReEnterPasswordFieldEnabled = true;

  @override
  void initState(){
    super.initState();
    callPopulate();
  }

  populate() async{
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final isGoogleSignIn = await authNotifier.checkGoogleSignIn();

    if(isGoogleSignIn){
      setState(() {
        String storedEmail = authState.asData?.value?.email ?? '';
        String storedFirstName = authState.asData?.value?.displayFirstName ?? '';
        String storedLastName = authState.asData?.value?.displayLastName ?? '';
        String storedUsername = authState.asData?.value?.userName ?? '';
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
    void dispose(){
      email.dispose();
      first_name.dispose();
      last_name.dispose();
      username.dispose();
      password.dispose();
      password2.dispose();
      super.dispose();
    }

  signupGoogle() async{
    final authNotifier = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);


    if(password.text != password2.text){
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try{
    final currentUser = UserRepository(ref);
    await currentUser.createUserDocIfNeeded(email.text, username.text, first_name.text, last_name.text, password.text);
    dispose(); //Add a non-goole version later.
    Get.offAll(() => const Wrapper());
    } on FirebaseAuthException catch(e){
        Get.snackbar(
          "Error",
          "Unexpected Firebase Sign-In Error: ${e.toString()}",
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

  signupNative()async{
    final authNotifier = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);
    if(password.text != password2.text){
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try{
    authNotifier.createFirebaseAccount(email.text, password.text);
    final currentUser = UserRepository(ref);

    await currentUser.createUserDocIfNeeded(email.text, username.text, first_name.text, last_name.text, password.text);
    dispose(); //Add a non-goole version later.
    Get.offAll(() => const Wrapper());
    } on FirebaseAuthException catch(e){
        Get.snackbar(
          "Error",
          "Unexpected Firebase Sign-In Error: ${e.toString()}",
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

  @override
  Widget build(BuildContext context) {

    populate();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Hive Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
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
                      'Create your student account', 
                      style: TextStyle(
                        fontSize: 16, 
                        fontFamily: 'Inter'
                      ),
                    ),
                    const SizedBox(height: 15,),
                    TextField(
                      controller: email,
                      enabled: _isEmailFieldEnabled,
                      decoration: const InputDecoration(hintText: 'email@domain.com'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: username,
                      enabled: _isUsernameFieldEnabled,
                      decoration: const InputDecoration(hintText: 'username'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: first_name,
                      enabled: _isFirstNameFieldEnabled,
                      decoration: const InputDecoration(hintText: 'first name'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: last_name,
                      enabled: _isLastNameFieldEnabled,
                      decoration: const InputDecoration(hintText: 'last name'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password,
                      enabled: _isPasswordFieldEnabled,
                      decoration: const InputDecoration(hintText: 'password'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password2,
                      enabled: _isReEnterPasswordFieldEnabled,
                      decoration: const InputDecoration(hintText: 're-enter password'),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (() async{
                        final isGoogleSignIn = await checkGoogleSignIn();

                        if(isGoogleSignIn == true){
                          signupGoogle();
                        }
                        else{
                          signupNative();
                        }
                      }),
                      child: const Text("Sign Up")
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 149, 252, 124),
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
                            image: AssetImage("assets/images/Student.png"),
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Student",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 86, 86), 
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
            ]
          ),
        ),
      )
    );
  }
}