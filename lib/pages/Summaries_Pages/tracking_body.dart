import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/models/user_models/task_model.dart';
import 'package:flutter_app/widgets/tasks_deadline_widget.dart';

class TrackingBody extends StatelessWidget {
  const TrackingBody({super.key, required void Function(NavigationPage page) onNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        children: [
          //Need to get the list of tasks from the database and pass it to the TasksDeadlineWidget. For now, I'm just passing fake tasks for testing..
          TasksDeadlineWidget(tasks: [
            TaskModel(
              task_name: 'Task 1',
              date_due: DateTime.now().add(const Duration(days: 2)),
              date_assigned: DateTime.now(),
              task_description: 'Description 1',
              users_tasked: [],
              hive_ID: '1',
              hive_name: 'Hive 1',
              difficulty: 'Medium',
              taskType: 'Work',
              gc_task: false,
              tradeable: false,
            ),
            TaskModel(
              task_name: 'Task 2',
              date_due: DateTime.now().add(const Duration(days: 5)),
              date_assigned: DateTime.now(),
              task_description: 'Description 2',
              users_tasked: [],
              hive_ID: '2',
              hive_name: 'Hive 2',
              difficulty: 'Hard',
              taskType: 'Personal',
              gc_task: false,
              tradeable: false,
            ),
          ]),
        ],
      ),
    );
  }
}