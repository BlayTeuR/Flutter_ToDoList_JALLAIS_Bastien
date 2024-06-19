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

  void createTask(Task newTask) {
    _tasks.add(newTask);
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
