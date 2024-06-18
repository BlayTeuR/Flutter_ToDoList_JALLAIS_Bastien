import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/tasks_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  const TaskPreview({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title ?? 'No Title',
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(task.content),
      leading: Icon(
        task.completed ? Icons.check_circle : Icons.circle,
        color: task.completed ? Colors.green : Colors.red,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(task: task),
          ),
        );
      },
    );
  }
}
