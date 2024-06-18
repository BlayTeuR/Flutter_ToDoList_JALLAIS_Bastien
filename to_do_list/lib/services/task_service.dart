import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'package:to_do_list/models/task.dart';

class TaskService {
  final faker = Faker();
  final uuid = const Uuid();
  List<Task> _tasks = [];

  TaskService() {
    _tasks = List.generate(
      10,
          (index) => Task(
        pid: uuid.v4(),
        title: faker.lorem.sentence(),
        content: faker.lorem.sentences(3).join(' '),
        completed: faker.randomGenerator.boolean(),
      ),
    );
  }

  List<Task> get tasks => _tasks;

  Future<void> createTask(Task newTask) async {
    _tasks.add(newTask);
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
