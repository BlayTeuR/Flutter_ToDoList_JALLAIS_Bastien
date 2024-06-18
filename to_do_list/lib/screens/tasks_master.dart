import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_preview.dart';
import 'package:to_do_list/screens/task_form.dart';
import 'package:to_do_list/services/task_service.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  final TaskService _taskService = TaskService(); // Instance de TaskService
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() {
    _taskService.fetchTasks().then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    }).catchError((error) {
      print('Error fetching tasks: $error');
      // Gérer les erreurs si nécessaire
    });
  }

  void _addTask(Map<String, dynamic> taskData) {
    Task newTask = Task(
      title: taskData['title'],
      content: taskData['content'],
      completed: taskData['completed'],
    );
    setState(() {
      _tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _tasks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          Task task = _tasks[index];
          return TaskPreview(task: task);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskForm()),
          );
          if (result != null) {
            _addTask(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
