import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/todo_list_app.dart';

void main() {
  runApp(ToDoListApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        title: 'ToDo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ToDoListApp(),
      ),
    );
  }
}
