import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum TaskImportance {
  basse,
  moyenne,
  forte,
}

class Task {
  String? id;
  String content;
  bool completed;
  String? title;
  TaskImportance importance;

  Task({
    required this.content,
    this.title,
    String? pid,
    required this.completed,
    this.importance = TaskImportance.basse,
  }) : id = pid ?? uuid.v4();

  @override
  String toString() {
    return "Task(content: $content, id: $id, title: $title, completed: $completed, importance: $importance)";
  }
}
