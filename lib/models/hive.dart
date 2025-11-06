import 'package:firebase_auth/firebase_auth.dart';

class Hive {
  final Map appreciation_snippet;
  final Map default_settings;
  final Map task_snippet;
  final Map tasks;
  final Map recent_updates;
  final Map group_users;

  const Hive({
    required this.appreciation_snippet,
    required this.default_settings,
    required this.task_snippet,
    required this.tasks,
    required this.recent_updates,
    required this.group_users,
  });

  factory Hive.createNewHive({
    required Map appreciation_snippet,
    required Map default_settings,
    required Map task_snippet,
    required Map tasks,
    required Map recent_updates,
    required Map group_users
  }){
    return Hive(
      appreciation_snippet: appreciation_snippet, 
      default_settings: default_settings, 
      task_snippet: task_snippet, 
      tasks: tasks, 
      recent_updates: recent_updates, 
      group_users: group_users);
  }

  //Add a copyWith later.
}