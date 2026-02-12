import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Hives_Pages/specific_hive.dart';
import 'package:flutter_app/pages/Summaries_Pages/notifications.dart';
import 'package:flutter_app/widgets/hive_widget.dart';
import 'package:flutter_app/widgets/nectar_center_points_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class HivesBody extends StatefulWidget {
  final Function(NavigationPage)? onNavigate;
  const HivesBody({super.key, this.onNavigate});

  @override
  State<HivesBody> createState() => _HivesBodyState();
}

class _HivesBodyState extends State<HivesBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Scrollable(
          viewportBuilder: (context, position) {
            return Center(
              child: Column(
                children: [
                  const NectarCenterPointsWidget(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                          title: const Text("Join Hive"),
                          content: const Text("Enter the code for the hive you want to join."),
                          actions: [
                            const TextField(
                              decoration: InputDecoration(hintText: "Hive Code"),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {}, //Need to implement joining a hive with a code. For now, this button does nothing.
                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 35, 116, 38)),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.group_add, size: 30, color: Colors.white),
                                  SizedBox(width: 20),
                                  Text("Join", style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ]
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(180, 70), maximumSize: const Size(250, 75), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.search, size: 30, color: Color(0xFFFF0000)), SizedBox(width: 10), Text("Join Hive", style: TextStyle(fontFamily: 'Jomhuria', fontSize: 40, color: Color(0xFFFF0000)))]),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => {
                      widget.onNavigate!(NavigationPage.createHive),
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(180, 70), maximumSize: const Size(250, 75), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.group_add_outlined, size: 30, color: Color(0xFFFF0000)), SizedBox(width: 10), Text("Create Hive", style: TextStyle(fontFamily: 'Jomhuria', fontSize: 40, color: Color(0xFFFF0000)))]),
                  ),
                  const SizedBox(height: 15),
                  const Text("My Hives", style: TextStyle(fontFamily: 'Jomhuria', fontSize: 50, color: Colors.black)),
                  ...[
                    HiveWidget(hiveColor: Colors.blue, hiveIcon: const Icon(Icons.travel_explore), hiveName: "Hive 1", hivePage: const SpecificHive(hiveColor: Colors.blue, hiveIcon: Icon(Icons.travel_explore), hiveName: "Hive 1"), onTap: () => widget.onNavigate!(NavigationPage.specificHive)),
                    const SizedBox(height: 5),
                    HiveWidget(hiveColor: Colors.green, hiveIcon: const Icon(Icons.access_alarm), hiveName: "Hive 2", hivePage: const SpecificHive(hiveColor: Colors.green, hiveIcon: Icon(Icons.access_alarm), hiveName: "Hive 2"), onTap: () => widget.onNavigate!(NavigationPage.specificHive)),
                    const SizedBox(height: 5),
                    HiveWidget(hiveColor: Colors.pink, hiveIcon: const Icon(Icons.engineering), hiveName: "Hive 3", hivePage: const SpecificHive(hiveColor: Colors.pink, hiveIcon: Icon(Icons.engineering), hiveName: "Hive 3"), onTap: () => widget.onNavigate!(NavigationPage.specificHive)),
                    const SizedBox(height: 5),
                    HiveWidget(hiveColor: Colors.orange, hiveIcon: const Icon(Icons.bike_scooter), hiveName: "Hive 4", hivePage: const SpecificHive(hiveColor: Colors.orange, hiveIcon: Icon(Icons.bike_scooter), hiveName: "Hive 4"), onTap: () => widget.onNavigate!(NavigationPage.specificHive)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}