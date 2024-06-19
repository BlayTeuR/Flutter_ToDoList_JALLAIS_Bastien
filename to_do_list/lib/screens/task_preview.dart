import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/tasks_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskToggled;
  final Function(Task) onTaskUpdated;
  final Function(String) onTaskDeleted;

  const TaskPreview({
    Key? key,
    required this.task,
    required this.onTaskToggled,
    required this.onTaskUpdated,
    required this.onTaskDeleted,
  }) : super(key: key);

  Color _getImportanceColor(TaskImportance importance) {
    switch (importance) {
      case TaskImportance.basse:
        return Colors.blue;
      case TaskImportance.moyenne:
        return Colors.orange;
      case TaskImportance.forte:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: task.completed ? Colors.green[100] : Colors.red[100],
        margin: EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            task.title ?? '',
            style: TextStyle(
              color: task.completed ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Text(task.content ?? ''),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getImportanceColor(task.importance),
                ),
              ),
              SizedBox(width: 8),
              Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      task.completed ? Icons.cancel : Icons.check,
                      color: task.completed ? Colors.red : Colors.green,
                    ),
                    onPressed: () => onTaskToggled(task),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onTaskDeleted(task.id!),
                  ),
                ],
              ),
            ],
          ),
          onTap: () async {
            final updatedTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetails(
                  task: task,
                  onTaskUpdated: onTaskUpdated,
                ),
              ),
            );

            if (updatedTask != null) {
              onTaskUpdated(updatedTask);
            }
          },
        ),
      ),
    );
  }
}
