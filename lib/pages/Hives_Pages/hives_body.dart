import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Hives_Pages/create_hive.dart';
import 'package:flutter_app/pages/Hives_Pages/specificHive.dart';
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
  List<HiveWidget> userHives = [
    const HiveWidget(hiveColor: Colors.blue, hiveIcon: Icon(Icons.travel_explore), hiveName: "Hive 1", hivePage: SpecificHive(hiveColor: Colors.blue, hiveIcon: Icon(Icons.travel_explore), hiveName: "Hive 1")),
    const HiveWidget(hiveColor: Colors.green, hiveIcon: Icon(Icons.access_alarm), hiveName: "Hive 2", hivePage: SpecificHive(hiveColor: Colors.green, hiveIcon: Icon(Icons.access_alarm), hiveName: "Hive 2")),
    const HiveWidget(hiveColor: Colors.pink, hiveIcon: Icon(Icons.engineering), hiveName: "Hive 3", hivePage: SpecificHive(hiveColor: Colors.pink, hiveIcon: Icon(Icons.engineering), hiveName: "Hive 3")),
    const HiveWidget(hiveColor: Colors.orange, hiveIcon: Icon(Icons.bike_scooter), hiveName: "Hive 4", hivePage: SpecificHive(hiveColor: Colors.orange, hiveIcon: Icon(Icons.bike_scooter), hiveName: "Hive 4")),
  ];
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
                    onPressed: () {/* Join hive */},
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
                  ...userHives.expand((widget) => [widget, const SizedBox(height: 5)]).toList()..removeLast(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}