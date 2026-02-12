import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/widgets/normal_task_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecificHive extends ConsumerStatefulWidget {
  final Color hiveColor;
  final Icon hiveIcon;
  final String hiveName;
  final Function(NavigationPage)? onNavigate;
  const SpecificHive({required this.hiveColor, required this.hiveIcon, required this.hiveName, super.key, this.onNavigate});
  @override
  ConsumerState<SpecificHive> createState() => _SpecificHiveState();
}
class _SpecificHiveState extends ConsumerState<SpecificHive> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        children: [
          const NormalTaskWidget(
            title: "My Tasks",
            tasks: [
              {'name': 'Complete Math Homework', 'description': 'Finish chapter 5 exercises'},
              {'name': 'Read Science Chapter', 'description': 'Read pages 45-67'},
              {'name': 'Write Essay', 'description': '500-word essay on climate change'},
              {'name': 'Study for Test', 'description': 'Review biology notes'},
            ],
          ),
          //Add Google Classroom tasks widget here.
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => {}, //Need to implement navigation to the hive's task dashboard.
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100000000))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.list, size: 30, color: Color(0xFFFF0000)), SizedBox(width: 10), Text("Task Dashboard", style: TextStyle(fontFamily: 'Jomhuria', fontSize: 40, color: Color(0xFFFF0000)))]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => widget.onNavigate!(NavigationPage.addTasks),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100000000))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.track_changes, size: 30, color: Color(0xFF00FF73)), SizedBox(width: 10), Text("Add Tasks", style: TextStyle(fontFamily: 'Jomhuria', fontSize: 40, color: Color(0xFF00FF73)))]),
          ),
        ],
      ),
    );
  }
}