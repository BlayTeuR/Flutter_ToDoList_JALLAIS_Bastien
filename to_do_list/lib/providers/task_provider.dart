import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/task_service.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  TasksProvider() {
    _tasks = _taskService.tasks;
  }

  List<Task> get tasks => _tasks;

  void addTask(Task newTask) {
    _taskService.createTask(newTask);
    _tasks.add(newTask);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void removeTask(String taskId) {
    _taskService.deleteTask(taskId);
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Task? getTaskById(String pid) {
    try {
      return _tasks.firstWhere((task) => task.id == pid);
    } catch (e) {
      return null;
    }
  }
}
