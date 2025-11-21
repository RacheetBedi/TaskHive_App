
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
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fancy_password_field/fancy_password_field.dart';

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
  final FancyPasswordController _password = FancyPasswordController();

  bool _isEmailFieldEnabled = true;
  bool _isFirstNameFieldEnabled = true;
  bool _isLastNameFieldEnabled = true;
  bool _isUsernameFieldEnabled = true;
  bool _isPasswordFieldEnabled = true;
  bool _isReEnterPasswordFieldEnabled = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final FocusNode focusNode = FocusNode();

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
      _password.dispose();
      password2.dispose();
      super.dispose();
    }

  signupGoogle() async{
    final authNotifier = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);

    try{
    final currentUser = UserRepository(ref);
    await currentUser.createUserDocIfNeeded(email.text, username.text, first_name.text, last_name.text, password.text);//Add a non-goole version later.

    authState.asData!.value!.hasCompletedSetup = true;
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

    try{
    await authNotifier.createFirebaseAccount(email.text, password.text);
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
                    Column(
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
                            fontSize: 50, 
                            fontFamily: 'Jomhuria'
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
                          decoration:  InputDecoration(
                            hintText: 're-enter password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureText2 ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: (){
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              // PasswordCheck(password: password.text, password2: password2.text,);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        PasswordCheck(password: password.text, password2: password2.text),
                        // TextField(
                        //   controller: password2,
                        //   enabled: _isReEnterPasswordFieldEnabled,
                        //   decoration: const InputDecoration(hintText: 're-enter password'),
                        // ),
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
                               final isGoogleSignIn = await checkGoogleSignIn();
                    
                              if(isGoogleSignIn == true){
                                signupGoogle();
                              }
                              else{
                                signupNative();
                              }
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){
                                    Get.offAll(() => Role());
                                    return;
                                  },
                                  child: const Image(
                                    image: AssetImage("assets/images/Student.png"),
                                    height: 50,
                                  ),
                                )
                              ),
                              const Padding(
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
                    ]
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

                      // strengthIndicatorBuilder: (double strength){
                      //   String label;
                      //   Color color;

                      //   if(strength < 0.33){
                      //     label = "Weak";
                      //     color = Colors.red;
                      //   } else if (strength < 0.66){
                      //     label = 'Fair';
                      //     color = Colors.orange;
                      //   } else{
                      //     label = 'Strong';
                      //     color = Colors.green;
                      //   }

                      //   return Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets,
                      //       ),
                      //     ],
                      //   )
                      // },

                    // TextFormField(
                    //   controller: password,
                    //   obscureText: _obscureText1,
                    //   decoration:  InputDecoration(
                    //     hintText: 'password',
                    //     suffixIcon: IconButton(
                    //       icon: Icon(
                    //           _obscureText1 ? Icons.visibility_off : Icons.visibility,
                    //           color: Theme.of(context).primaryColorDark,
                    //       ),
                    //       onPressed: (){
                    //         setState(() {
                    //           _obscureText1 = !_obscureText1;
                    //         });
                    //       },
                    //       )),
                    // ),
                    // TextField(
                    //   controller: password,
                    //   enabled: _isPasswordFieldEnabled,
                    //   decoration: const InputDecoration(hintText: 'password'),
                    // ),

