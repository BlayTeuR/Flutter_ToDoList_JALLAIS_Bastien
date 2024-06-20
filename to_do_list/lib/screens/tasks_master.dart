import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_form.dart';
import 'package:to_do_list/screens/task_preview.dart';

import '../providers/task_provider.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  TextEditingController _searchController = TextEditingController();
  late List<Task> _filteredTasks;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _filteredTasks = [];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<TasksProvider>(context, listen: false).fetchTasks().then((_) {
        setState(() {
          _isLoading = false;
          _filteredTasks = Provider.of<TasksProvider>(context, listen: false).tasks;
        });
      });
    });

    _searchController.addListener(() {
      _searchTasks(_searchController.text);
    });
  }

  void _searchTasks(String searchText) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    setState(() {
      _filteredTasks = tasksProvider.tasks.where((task) {
        final titleMatches = task.title != null && task.title!.toLowerCase().contains(searchText.toLowerCase());
        final contentMatches = task.content != null && task.content!.toLowerCase().contains(searchText.toLowerCase());
        return titleMatches || contentMatches;
      }).toList();
    });
  }

  Future<void> _showAddTaskDialog() async {
    final result = await showDialog<Task>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TaskForm(formMode: FormMode.Add),
          ),
        );
      },
    );

    if (result != null) {
      Task newTask = Task(
        title: result.title ?? '',
        content: result.content,
        completed: result.completed ?? false,
        importance: result.importance,
      );

      Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    _filteredTasks = tasksProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchTasks,
              decoration: InputDecoration(
                labelText: 'Search tasks...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredTasks.isEmpty
                ? Center(child: Text('No tasks found.'))
                : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                Task task = _filteredTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TaskPreview(
                    task: task,
                    onTaskToggled: (t) => tasksProvider.updateTask(t),
                    onTaskUpdated: (t) => tasksProvider.updateTask(t),
                    onTaskDeleted: (id) => tasksProvider.deleteTask(id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
