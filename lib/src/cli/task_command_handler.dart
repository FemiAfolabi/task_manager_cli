import 'dart:io';

import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/services/task_service.dart';

enum CommandType { create, list, complete, delete, help, quit, unknown }

final class TaskCommandHandler {
  final TaskService _service;

  TaskCommandHandler({required this._service});

  Future<void> run() async {
    print('Bienvenue dans le gestionnaire de tâches CLI');
    print('Tapez "help" pour la liste des commandes ou "quit" pour quitter\n');

    while (true) {
      stdout.write('> ');
      final String? input = stdin.readLineSync();

      if (input == null) {
        print('\nFin de la session');
        break;
      }

      final (commandType, args) = _parseCommand(input);

      if (commandType == CommandType.quit) {
        print('\nFin de la session');
        break;
      }

      // AJOUT : await devant _handleCommand
      await _handleCommand(commandType, args);
    }
  }

  (CommandType, List<String>) _parseCommand(String input) {
    final parts = input.trim().toLowerCase().split(' ');

    return switch (parts) {
      ['quit'] => (CommandType.quit, <String>[]),
      ['help'] => _showHelp(),
      ['list'] => (CommandType.list, <String>[]),
      ['create', var title] => (CommandType.create, [title]),
      ['complete', var title] => (CommandType.complete, [title]),
      ['delete', var title] => (CommandType.delete, [title]),
      _ => (CommandType.unknown, parts),
    };
  }

  // CHANGEMENT : retour Future<void>
  Future<void> _handleCommand(CommandType type, List<String> args) async {
    switch (type) {
      case CommandType.help:
        break; // déjà affiché dans _parseCommand
      case CommandType.list:
        await _listTasks(); // AJOUT await
        break;
      case CommandType.create:
        if (args.isNotEmpty) {
          await _createTask(args.first);
        }
        break;
      case CommandType.complete:
        if (args.isNotEmpty) {
          await _completeTask(args.first);
        }
        break;
      case CommandType.delete:
        if (args.isNotEmpty) {
          await _deleteTask(args.first);
        }
        break;
      case CommandType.quit:
        break;
      case CommandType.unknown:
        print(
          'Commande inconnue. Tapez "help" pour voir les commandes disponibles.',
        );
        break;
    }
  }

  // CHANGEMENT : retour Future<void>
  Future<void> _listTasks() async {
    final tasks = await _service.listTasks();

    if (tasks.isEmpty) {
      print('Aucune tâche disponible');
      return;
    }

    for (final task in tasks) {
      final status = task.isCompleted ? '[x]' : '[ ]';
      print(
        '$status - ${task.title}   (${task.priority.name}) "${task.status}"',
      );
    }
  }

  Future<void> _createTask(String title) async {
    try {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      );

      await _service.addTask(task);
      print('La tâche "$title" a été créée avec succès');
    } catch (e) {
      print('Erreur lors de la création de la tâche : $e');
    }
  }

  Future<void> _completeTask(String title) async {
    try {
      final tasks = await _service.listTasks();
      final task = tasks.firstWhere((t) => t.title == title);
      task.complete();

      // On met à jour la tâche dans le service (et donc dans le fichier)
      await _service.updateTask(task);
      print('✅ La tâche "${task.title}" a été terminée avec succès.');
    } catch (e) {
      print('❌ Erreur : impossible de terminer la tâche $title');
    }
  }

  Future<void> _deleteTask(String title) async {
    try {
      // Récupérer la liste actuelle, puis la filtrer
      final normalyzedTitle = title.trim().toLowerCase();
      final tasks = await _service.listTasks();
      final updatedTasks = tasks
          .where((t) => t.title != normalyzedTitle)
          .toList();

      if (tasks.length == updatedTasks.length) {
        print('Erreur : aucune tâche trouvée avec l\'ID $title');
        return;
      }

      // Appel d'une nouvelle méthode deleteTask dans le service
      await _service.deleteTask(title);
      print('Tâche $title supprimée avec succès.');
    } catch (e) {
      print('Erreur lors de la suppression : $e');
    }
  }

  (CommandType, List<String>) _showHelp() {
    print('''
Commandes disponibles :
  list                - Affiche la liste des tâches
  create <titre>      - Crée une nouvelle tâche
  complete <title>       - Marque la tâche comme terminée
  delete <title>         - Supprime la tâche
  help                - Affiche cette aide
  quit                - Quitte l'application
''');
    return (CommandType.unknown, <String>[]);
  }
}
