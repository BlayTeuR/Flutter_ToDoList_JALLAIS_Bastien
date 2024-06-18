import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Créer la tâche avec les données du formulaire
      Map<String, dynamic> newTaskData = {
        'title': _titleController.text,
        'content': _contentController.text,
        'completed': false, // Vous pouvez ajouter la logique pour gérer le statut complet ici
      };

      // Retourner les données de la nouvelle tâche à la page précédente
      Navigator.of(context).pop(newTaskData);
    } else {
      // Form is invalid, show alert
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une tâche'),
      ),
      body: Padding(
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
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
