import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  String? id;
  String content;
  bool completed;
  String? title;

  Task({required this.content, this.title, String? pid, required this.completed})
      : id = pid ?? uuid.v4();

  @override
  String toString() {
    return "Task(content: $content, id: $id, title: $title, completed: $completed)";
  }
}
