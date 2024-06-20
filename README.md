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

Etape 5:
- création de taskService (je prend mtn les pdf sur discord et non ent)
- changement de taskmaster pour utiliser taskservice
- Ajout possible d'une tache dans la liste de tache à partir d'un formulaire, affiche des erreurs si le formulaire est mal remplie

Mauvais point : je n'arrive pas à faire fonctionner le bouton qui affiche lors formulaire lorsque j'ajoute celui-ci dans todo_list_app
c'est pourquoi je le place dans taskMaster

Etape 6:
- Mise en place du provider
- Amélioration de l'esthétisme général de l'application
- Ajout de fonctionnalité comme la suppression de tâche avec un icône poubelle ou encore de la la sélectionner du tâche terminé sur la liste principale ou inversement

Etape 7:
- modification du formualaire (s'affiche maintenant sous forme du fenetre modale)
- suppression du scaffold dans task_form
- Ajout de l'importance d'une tache (basse, moyenne, forte) 
- Ajout d'une barre de recherche

Etape 8:
- Correction de l'erreur des méthodes update, delete, ect également présente
- Mise en place de la base de donnée supabase
