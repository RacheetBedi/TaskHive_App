import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/role.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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

  final String pdlApiKey = 'ed8540c975fb8e6345d1ef14611b8e09c56b7fd3ce0e3c6ad701a593003665aa';
  Map<String, dynamic>? _selectedSchool;

  Future<List<Map<String, dynamic>>> getSchools(String query) async{
    if(query.length <2){
      return [];
    }

    // final uri = Uri.https(
    //   'api.peopledatalabs.com',
    //   '/v5/autocomplete',
    //   {
    //     'api_key': pdlApiKey,
    //     'field': 'school',
    //     'text': query,
    //     'size': 10,
    //     'titlecase': 'true',
    //   }
    // );

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
                        fontSize: 16, 
                        fontFamily: 'Inter'
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
                    // TextField(
                    //   controller: school,
                    //   decoration: const InputDecoration(hintText: 'school name'),
                    //),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(hintText: 'password'),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: password2,
                      decoration: const InputDecoration(hintText: 're-enter password'),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: (()=> signup()),
                      child: const Text("Sign Up")
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
            ]
          ),
        ),
      )
    );
  }
}