import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'package:to_do_list/models/task.dart';

class TaskService {
  final faker = Faker();
  final uuid = const Uuid();

  Future<List<Task>> fetchTasks() async {
    List<Task> tasks = List.generate(
      100,
          (index) => Task(
        pid: uuid.v4(),
        title: faker.lorem.sentence(),
        content: faker.lorem.sentences(3).join(' '),
        completed: faker.randomGenerator.boolean(),
      ),
    );
    return tasks;
  }
}
