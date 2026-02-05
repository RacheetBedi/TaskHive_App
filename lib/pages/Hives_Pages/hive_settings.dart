import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/Home_Pages/main_page.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/settings.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/pages/Setup_Pages/signupTeacher.dart';
import 'package:flutter_app/pages/Hives_Pages/specificHive.dart';
import 'package:flutter_app/pages/Summaries_Pages/summary.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_app/widgets/hive_widget.dart';
import 'package:flutter_app/widgets/nectar_center_points_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:async/async.dart';

class HiveSettings extends ConsumerStatefulWidget {
  const HiveSettings({super.key});
  @override
  ConsumerState<HiveSettings> createState() => _HiveSettingsState();
}

class _HiveSettingsState extends ConsumerState<HiveSettings> {
  bool _nectarCenter = true;
  bool _taskTrading = true;
  bool _taskAddition = true;
  bool _taskRemoval = true;
  bool _aiSummary = false;
  bool _hiveNotifications = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Hive Background.png"),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.none,
        ),
      ),
      child: Column(
        children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Nectar Center',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _nectarCenter,
                      onChanged: (val) => setState(() => _nectarCenter = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Task Trading',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _taskTrading,
                      onChanged: (val) => setState(() => _taskTrading = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Task Addition',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _taskAddition,
                      onChanged: (val) => setState(() => _taskAddition = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Task Removal',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _taskRemoval,
                      onChanged: (val) => setState(() => _taskRemoval = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'AI Summary',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _aiSummary,
                      onChanged: (val) => setState(() => _aiSummary = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color:Color.fromARGB(115, 0, 0, 0),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 6.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text(
                      'Hive Notifications',
                      style: TextStyle(color: Colors.white, fontSize: 48, fontFamily: 'Jomhuria'),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                      value: _hiveNotifications,
                      onChanged: (val) => setState(() => _hiveNotifications = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}