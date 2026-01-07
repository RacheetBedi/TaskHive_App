import 'package:flutter/material.dart';

class NormalTaskWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> tasks;

  const NormalTaskWidget({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    int totalTasksDue = tasks.length;
    List<Map<String, dynamic>> displayedTasks = tasks.take(3).toList();
    return GestureDetector(
      onTap: () => _showAllTasksDialog(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total tasks due: $totalTasksDue',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              ...displayedTasks.map((task) => _buildTaskItem(task)),
              if (tasks.length > 3)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Tap to see all tasks',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Task icon or checkbox
          const Icon(Icons.task, size: 20, color: Colors.blue),
          const SizedBox(width: 8),

          // Task name
          Expanded(
            child: Text(
              task['name'] ?? task['taskname'] ?? 'Unnamed Task',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Task description preview
          if (task['description'] != null || task['taskdescription'] != null)
            Expanded(
              child: Text(
                task['description'] ?? task['taskdescription'] ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showAllTasksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '$title - All Tasks',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.task),
                          title: Text(task['name'] ?? task['taskname'] ?? 'Unnamed Task'),
                          subtitle: Text(
                            task['description'] ?? task['taskdescription'] ?? 'No description',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}