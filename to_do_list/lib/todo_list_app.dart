import 'package:flutter/material.dart';
import 'package:to_do_list/screens/tasks_master.dart';

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TasksMaster(),
    );
  }
}
