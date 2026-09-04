import 'dart:io';

import 'package:task_manager_cli/src/models/priority.dart';
import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/memory_task_repository.dart';
import 'package:task_manager_cli/src/services/task_service.dart';

void main() {
  _displayHeader();

  final repository = MemoryTaskRepository();
  final service = TaskService(repository: repository);

  print('Initialisation du gestionnaire...');

  final demoTask = Task(
    id: '001',
    title: 'Première tâche',
    priority: Priority.high,
    description: 'Tache créée pour tester ma classe Task',
  );

  service.addTask(demoTask);

  final tasks = service.listTasks();

  print('Nombre de tâches: ${tasks.length}');
  print('Détails:');
  for (var task in tasks) {
    print(
      '  - ${tasks.indexOf(task) + 1}. ${task.title}  ${task.priority.name}',
    );
  }

  print('\n');

  _displayHelp();
}

void _displayHeader() {
  print('============================================');
  print('     GESTIONNAIRE DE TACHES CLI AVANCÉ');
  print('      Flutter Engineering Academy S1');
  print('============================================');
  print('');
}

void _displayHelp() {
  print('Commandes simulées (disponible dans le module suivant) :');
  print('   - créer <titre>');
  print('   - lister');
  print('   - terminer <id>');
  print('   - supprimer <id>');
  print('   - quitter');
  print('');
  print('Appuyez sur entrée pour quitter');

  stdin.readLineSync();
}
