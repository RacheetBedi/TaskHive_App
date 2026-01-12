import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/pages/nectar_center.dart';

class NectarCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const NectarCenter());
      },
      child: Container(
        width: 250.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB743),
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: const Column(
          children: [
            Text(
              'Nectar Center',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '500 Points',
              style: TextStyle(
                color: Color.fromARGB(255, 68, 68, 68),
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
