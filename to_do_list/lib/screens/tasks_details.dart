import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_form.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskUpdated;

  const TaskDetails({Key? key, required this.task, required this.onTaskUpdated}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _contentController = TextEditingController(text: widget.task.content);
    _completed = widget.task.completed;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title ?? 'Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Update the task with the new values
              widget.task.title = _titleController.text;
              widget.task.content = _contentController.text;
              widget.task.completed = _completed;

              widget.onTaskUpdated(widget.task);

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: TaskForm(
        formMode: FormMode.Edit,
        task: widget.task,
      ),
    );
  }
}