import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

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

  void _saveChanges() {
    // Update the task object with the new values
    widget.task.title = _titleController.text;
    widget.task.content = _contentController.text;
    widget.task.completed = _completed;

    // You can save or update the task here using TaskService if needed

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Changes saved successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title ?? 'Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Completed'),
              value: _completed,
              onChanged: (value) {
                setState(() {
                  _completed = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
