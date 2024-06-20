import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum TaskImportance {
  basse,
  moyenne,
  forte,
}

class Task {
  String id;
  String? title;
  String content;
  bool completed;
  TaskImportance importance;

  Task({
    required this.content,
    this.title,
    String? pid,
    required this.completed,
    this.importance = TaskImportance.basse,
  }) : id = pid ?? uuid.v4();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      pid: json['id'] as String?,
      content: json['content'] as String,
      completed: json['completed'] as bool,
      title: json['title'] as String?,
      importance: TaskImportance.values.firstWhere(
            (e) => e.toString().split('.').last == json['importance'],
        orElse: () => TaskImportance.basse,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'completed': completed,
      'importance': importance.toString().split('.').last,
    };
  }

  Task copyWith({
    String? title,
    String? content,
    bool? completed,
    TaskImportance? importance,
  }) {
    return Task(
      content: content ?? this.content,
      title: title ?? this.title,
      pid: id,
      completed: completed ?? this.completed,
      importance: importance ?? this.importance,
    );
  }

  @override
  String toString() {
    return "Task(content: $content, id: $id, title: $title, completed: $completed, importance: $importance)";
  }
}
