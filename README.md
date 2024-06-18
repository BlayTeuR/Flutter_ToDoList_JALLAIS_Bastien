# Flutter_ToDoList_JALLAIS_Bastien

Etape 2:
- Initialisation de la structure du proejt avec le model Task ainsi que les deux widgets Stateful task_details et task_master
- Les deux widgets retourne actuellement deux container random

Etape 3:

- Mise en place de TaskMaster
  - utilise l'objet faker pour génrer aléatoirement des tasks
  - Utilisation de FutureBuilder afin d'afficher les tasks (permet également de gérer les erreurs)
  - Utilisation d'une icone de couleur verte si la task et completed, rouge sinon
  - utilisation de la fonction  CircularProgressIndicator quand les data charge

Etape 4:

- Utilisation de faker afin de créer de fausse tâche avec un titre un contenu
- si la tache est fini alors -> vert sinon -> rouge