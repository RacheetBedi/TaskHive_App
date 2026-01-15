import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/Setup_Pages/enterFinalDetails.dart';
import 'package:flutter_app/pages/Setup_Pages/final_steps_question.dart';
import 'package:flutter_app/pages/Setup_Pages/verifyPhone.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_io.dart';
import 'package:get/get_core/src/get_main.dart';

class Enterphonenumber extends ConsumerStatefulWidget {
  const Enterphonenumber({super.key});

  @override
  ConsumerState<Enterphonenumber> createState() => _EnterphonenumberState();
}

class _EnterphonenumberState extends ConsumerState<Enterphonenumber> {

  String _code = '1';

  TextEditingController phone = TextEditingController();

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
                    onPressed: () => Get.back(),
                  ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
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
                    const SizedBox(height: 15),
                    const Text(
                      'Enter Your Phone Number',
                      style: TextStyle(
                        fontSize: 50, 
                        fontFamily: 'Jomhuria'
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your phone number for your account.\nAfter clicking enter, you will receive a verification message. \nNOTE: Standard SMS rates may apply.',
                      style: TextStyle(
                        fontSize: 20.0, 
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: DropdownMenu<CountryCodeLabel>(
                            initialSelection: CountryCodeLabel.america,
                            onSelected: (CountryCodeLabel? countryCode) {
                              setState(() {
                                _code = countryCode?.label ?? "+1";
                              });
                            },
                            dropdownMenuEntries: CountryCodeLabel.entries
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: phone,
                      decoration: const InputDecoration(hintText: 'Phone number'),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () => Get.to(() => VerifyPhone(phone.text)),
                      child: const Text("Send Message")
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () => Get.to(()=> const EnterfinalDetails()),//Go to the enterFinalDetails.dart page, not this one.
                      child: const Text('Enter Number Later'),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

typedef CountryCodeEntry = DropdownMenuEntry<CountryCodeLabel>;

enum CountryCodeLabel{
  america('+1'),
  canada('+1'),
  unitedKingdom('+44'),
  australia('+61'),
  germany('+49'),
  france('+33'),
  italy('+39'),
  netherlands('+31'),

  const CountryCodeLabel(this.label);
  final String label;

  static final List<DropdownMenuEntry<CountryCodeLabel>> entries =
      CountryCodeLabel.values.map((countryCode) {
    return DropdownMenuEntry<CountryCodeLabel>(
      value: countryCode,
      label: countryCode.label,
    );
  }).toList();
}
