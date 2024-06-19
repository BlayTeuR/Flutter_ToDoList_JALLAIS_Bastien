import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({Key? key, required this.formMode, this.task}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _completed = false;
  TaskImportance _importance = TaskImportance.basse;

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit && widget.task != null) {
      _titleController.text = widget.task!.title ?? '';
      _contentController.text = widget.task!.content;
      _completed = widget.task!.completed;
      _importance = widget.task!.importance;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Task taskData = Task(
        pid: widget.task?.id,
        title: _titleController.text,
        content: _contentController.text,
        completed: _completed,
        importance: _importance, // Assigner l'importance
      );

      Navigator.of(context).pop(taskData);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Form Error'),
          content: Text('Veuillez remplir tous les champs du formulaire'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez ajouter un titre';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Contenu'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez ajouter du contenu';
                }
                return null;
              },
              maxLines: null,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<TaskImportance>(
              value: _importance,
              onChanged: (value) {
                setState(() {
                  _importance = value!;
                });
              },
              items: TaskImportance.values.map((importance) {
                return DropdownMenuItem<TaskImportance>(
                  value: importance,
                  child: Text(importance.toString().split('.').last),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Importance'), // Libellé du menu déroulant
            ),
            if (widget.formMode == FormMode.Edit) ...[
              SizedBox(height: 16),
              SwitchListTile(
                title: Text('Complétée'),
                value: _completed,
                onChanged: (value) {
                  setState(() {
                    _completed = value;
                  });
                },
              ),
            ],
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.formMode == FormMode.Add ? 'Ajouter' : 'Modifier'),
            ),
          ],
        ),
      ),
    );
  }
}
