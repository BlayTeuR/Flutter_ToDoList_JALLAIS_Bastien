import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_form.dart';
import 'package:to_do_list/screens/task_preview.dart';
import 'package:to_do_list/services/task_service.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  final TaskService _taskService = TaskService();
  late List<Task> _tasks;
  late List<Task> _filteredTasks;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tasks = _taskService.tasks;
    _filteredTasks = _tasks;

    _searchController.addListener(() {
      _searchTasks(_searchController.text);
    });
  }

  void _searchTasks(String searchText) {
    setState(() {
      _filteredTasks = _tasks.where((task) {
        String title = task.title?.toLowerCase() ?? '';
        String content = task.content.toLowerCase();
        String query = searchText.toLowerCase();
        return title.contains(query) || content.contains(query);
      }).toList();
    });
  }

  void _addTask(Map<String, dynamic> taskData) {
    bool taskExists = _taskService.tasks.any((task) => task.id == taskData['pid']);
    if (taskExists) {
      print('Task already exists with the same ID');
      return;
    }
    Task newTask = Task(
      pid: taskData['pid'],
      title: taskData['title'],
      content: taskData['content'],
      completed: taskData['completed'] ?? false,
    );
    _taskService.createTask(newTask);
    setState(() {
      _tasks.add(newTask);
      _filteredTasks = _tasks;
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _updateTask(Task updatedTask) {
    setState(() {
      int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        _filteredTasks = _tasks;
      }
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _taskService.deleteTask(taskId);
      _tasks.removeWhere((task) => task.id == taskId);
      _filteredTasks = _tasks; // Update filtered tasks list
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
      _addTask({
        'pid': result.id,
        'title': result.title,
        'content': result.content,
        'completed': result.completed,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TaskSearchDelegate(_tasks),
              );
            },
          ),
        ],
      ),
      body: _filteredTasks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _filteredTasks.length,
        itemBuilder: (context, index) {
          Task task = _filteredTasks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TaskPreview(
              task: task,
              onTaskToggled: _toggleTaskCompletion,
              onTaskUpdated: _updateTask,
              onTaskDeleted: _deleteTask,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate<Task?> {
  final List<Task> tasks;

  TaskSearchDelegate(this.tasks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Fermer avec null lorsque la flèche de retour est pressée
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Task> filteredTasks = tasks.where((task) {
      String title = task.title?.toLowerCase() ?? '';
      String content = task.content.toLowerCase();
      String queryText = query.toLowerCase();
      return title.contains(queryText) || content.contains(queryText);
    }).toList();

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        Task task = filteredTasks[index];
        return ListTile(
          title: Text(task.title ?? ''),
          subtitle: Text(task.content),
          onTap: () {
            close(context, task); // Fermer avec la tâche sélectionnée
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Task> suggestionList = tasks.where((task) {
      String title = task.title?.toLowerCase() ?? '';
      String content = task.content.toLowerCase();
      String queryText = query.toLowerCase();
      return title.contains(queryText) || content.contains(queryText);
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Task task = suggestionList[index];
        return ListTile(
          title: Text(task.title ?? ''),
          subtitle: Text(task.content),
          onTap: () {
            query = task.title ?? '';
            close(context, task);
          },
        );
      },
    );
  }
}

