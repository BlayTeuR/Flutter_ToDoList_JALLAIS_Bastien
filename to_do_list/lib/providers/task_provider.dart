import 'package:flutter/foundation.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/task_service.dart';

class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await _taskService.fetchTasks();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch tasks: $e');
    }
  }

  Future<void> addTask(Task newTask) async {
    try {
      await _taskService.createTask(newTask);
      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      print('Failed to add task: $e');
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _taskService.updateTask(updatedTask);
      int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      print('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _taskService.deleteTask(taskId);
      _tasks.removeWhere((task) => task.id == taskId);
      notifyListeners();
    } catch (e) {
      print('Failed to delete task: $e');
    }
  }
}
