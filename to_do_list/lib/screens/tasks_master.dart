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
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
  }

  void _addTask(Map<String, dynamic> taskData) {
    bool taskExists = _taskService.tasks.any((task) => task.id == taskData['pid']);
    if (taskExists) {
      print('Task already exists with the same ID');
      return;
    }
    Task newTask = Task(
      pid: taskData['pid'],
      title: taskData['title'],
      content: taskData['content'],
      completed: taskData['completed'] ?? false,
    );
    _taskService.createTask(newTask);
    setState(() {});
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _updateTask(Task updatedTask) {
    setState(() {
      int index = _taskService.tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _taskService.tasks[index] = updatedTask;
      }
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _taskService.deleteTask(taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> _tasks = _taskService.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _tasks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          Task task = _tasks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TaskPreview(
              task: task,
              onTaskToggled: _toggleTaskCompletion,
              onTaskUpdated: _updateTask,
              onTaskDeleted: _deleteTask,
            ),
          );
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
