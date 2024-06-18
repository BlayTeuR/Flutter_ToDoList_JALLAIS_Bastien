import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/tasks_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskToggled;
  final Function(Task) onTaskUpdated;
  final Function(String) onTaskDeleted;

  const TaskPreview({Key? key, required this.task, required this.onTaskToggled, required this.onTaskUpdated, required this.onTaskDeleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: task.completed ? Colors.green.shade100 : Colors.red.shade100,
        border: Border.all(
          color: task.completed ? Colors.green : Colors.red,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
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
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: [
            IconButton(
              icon: Icon(task.completed ? Icons.close : Icons.check),
              onPressed: () {
                onTaskToggled(task);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onTaskDeleted(task.id!);
              },
            ),
          ],
        ),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(task: task),
            ),
          );
          if (result != null) {
            onTaskUpdated(result); // Met à jour la tâche après les modifications
          }
        },
      ),
    );
  }
}
