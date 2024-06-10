import 'package:flutter/material.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(width: 16),
            FloatingActionButton.small(
              onPressed: () {
                // Ajouter le on pressed ici
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
