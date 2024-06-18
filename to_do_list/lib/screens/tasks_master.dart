import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_preview.dart';
import 'package:to_do_list/screens/tasks_details.dart';
import 'package:to_do_list/services/task_service.dart';
import 'package:to_do_list/screens/task_form.dart'; // Importez TaskForm ici

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    // Pas besoin de charger les tâches ici, car elles sont déjà initialisées dans TaskService
  }

  void _addTask(Map<String, dynamic> taskData) {
    // Vérifiez si une tâche avec le même ID existe déjà
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
    setState(() {
      // Mettre à jour l'affichage après l'ajout de la tâche
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
