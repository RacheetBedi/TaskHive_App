import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/pages/Nectar_Center_Pages/nectar_center.dart';

class NectarCenterCommentsWidget extends StatefulWidget {
  const NectarCenterCommentsWidget({super.key});

  @override
  State<NectarCenterCommentsWidget> createState() => _NectarCenterCommentsWidgetState();
}

class _NectarCenterCommentsWidgetState extends State<NectarCenterCommentsWidget> {
  Icon userPfp = const Icon(
    Icons.account_circle, 
    size: 50,
    color: Colors.black,
  );
  String userName = "Mr. Bob";
  String userComment = "This is a sample comment for the Nectar Center!";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const NectarCenter());
      },
      child: Container(
        width: 300.0,
        height: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB743),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Nectar Center',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                userPfp,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userComment,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 68, 68, 68),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
