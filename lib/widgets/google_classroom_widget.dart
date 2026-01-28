import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Home_Pages/main_page.dart';
import 'package:get/get.dart';
import 'package:flutter_app/pages/Nectar_Center_Pages/nectar_center.dart';

class GoogleClassroomWidget extends StatefulWidget {
  const GoogleClassroomWidget({super.key});

  @override
  State<GoogleClassroomWidget> createState() => _GoogleClassroomWidgetState();
}

class _GoogleClassroomWidgetState extends State<GoogleClassroomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MainPage(CurIndex: 3));
      },
      child: Container(
        width: 300.0,
        height: 200,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB743),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: const Column(
          children: [
            Text(
              'GOOGLE CLASSROOM WIDGET PLACEHOLDER',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
