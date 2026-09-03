import 'dart:io';

import 'package:task_manager_cli/src/models/priority.dart';
import 'package:task_manager_cli/src/models/task.dart';

void main() {
  _displayHeader();

  try {
    final task1 = Task(
      id: '001',
      title: 'Première tâche',
      priority: Priority.high,
      description: 'Tache créée pour tester ma classe Task',
    );

    print('Tâche créée');
    print('ID: ${task1.id}');
    print('Titre : ${task1.title}');
    print('Description: ${task1.description}');
    print('Priorité: ${task1.priority.name}');
    print('Statut: ${task1.status.name}');
    print(' ');

    task1.complete();

    print('Tâche éffectuée');
    print('ID: ${task1.id}');
    print('Titre : ${task1.title}');
    print('Description: ${task1.description}');
    print('Priorité: ${task1.priority.name}');
    print('Statut: ${task1.status.name}');
    print(' ');
  } on ArgumentError catch (e) {
    print('Erreur de création de la tâche: $e');
  } on StateError catch (e) {
    print('Erreur d\'état: $e');
  }

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
