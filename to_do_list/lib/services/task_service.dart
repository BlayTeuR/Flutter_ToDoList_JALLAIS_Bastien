import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_list/models/task.dart';

class TaskService {
  final SupabaseClient _client = Supabase.instance.client;
  final String _tasksTable = 'tasks';

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _client.from(_tasksTable).select().execute();
      if (response.error != null) {
        throw Exception('Failed to fetch tasks: ${response.error!.message}');
      }

      final List<dynamic> data = response.data!;
      List<Task> tasks = data.map((json) => Task.fromJson(json)).toList();
      print('Fetched tasks: $tasks');
      return tasks;
    } catch (e) {
      print('Failed to fetch tasks: $e');
      throw Exception('Failed to fetch tasks: $e');
    }
  }


Future<void> createTask(Task newTask) async {
    final response = await _client.from(_tasksTable).insert(newTask.toJson()).execute();
    if (response.error != null) {
      throw Exception('Failed to create task: ${response.error!.message}');
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    final response = await _client.from(_tasksTable)
        .update(updatedTask.toJson())
        .eq('id', updatedTask.id)
        .execute();
    if (response.error != null) {
      throw Exception('Failed to update task: ${response.error!.message}');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await _client.from(_tasksTable).delete().eq('id', id).execute();
    if (response.error != null) {
      throw Exception('Failed to delete task: ${response.error!.message}');
    }
  }
}
