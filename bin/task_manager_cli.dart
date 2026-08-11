import 'package:task_manager_cli/src/task_actions.dart';

void main() {
  final String title = normalizedTaskTitle(' Etudier les fonctions ');

  if (!isValideTaskTitle(title)) {
    print('Entrez un titre valide');
    return;
  }

  final String summary = buildTaskSummary(
    title: title,
    isCompleted: false,
    description: 'Première tâche ajoutée avec succès',
  );

  print(summary);
  print(matchesKeyword(title: title, keyword: 'fonctions'));
}
