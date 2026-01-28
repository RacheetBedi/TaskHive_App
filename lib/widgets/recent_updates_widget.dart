import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:get/get.dart';
import 'package:flutter_app/pages/Nectar_Center_Pages/nectar_center.dart';

class RecentUpdatesWidget extends StatefulWidget {
  const RecentUpdatesWidget({super.key});

  @override
  State<RecentUpdatesWidget> createState() => _RecentUpdatesWidgetState();
}

class _RecentUpdatesWidgetState extends State<RecentUpdatesWidget> {
  Icon user1Pfp = const Icon(
    Icons.account_circle, 
    size: 50,
    color: Colors.black,
  );
  String user1Name = "Mr. Bob";
  String user1Action = "Completed task!";
  Icon user2Pfp = const Icon(
    Icons.account_circle, 
    size: 50,
    color: Colors.black,
  );
  String user2Name = "Ms. Alice";
  String user2Action = "Create new hive!";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RecentChanges());
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
        child: Column(
          children: [
            const Text(
              'Recent Updates',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                user1Pfp,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user1Name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user1Action,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 68, 68, 68),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                user2Pfp,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user2Name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user2Action,
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
