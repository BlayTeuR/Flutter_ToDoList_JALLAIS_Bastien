import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_preview.dart';
import 'package:to_do_list/screens/task_preview.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TaskMasterState createState() => _TaskMasterState();
}

class _TaskMasterState extends State<TasksMaster> {
  var faker = Faker();

  Future<List<Task>> _fetchTasks() async {
    List<Task> tasks = List.generate(
      100,
          (index) => Task(
        pTitle: faker.lorem.sentence(),
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
      ),
    );
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Task> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return TaskPreview(task: task);
            },
          );
        } else {
          return Center(child: Text('Aucune donnée disponible'));
        }
      },
    );
  }
}
