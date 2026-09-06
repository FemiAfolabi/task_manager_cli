import 'dart:io';

import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/services/task_service.dart';

enum CommandType { create, list, complete, delete, help, quit, unknown }

final class TaskCommandHandler {
  final TaskService _service;

  TaskCommandHandler({required this._service});

  Future<void> run() async {
    print('Bienvenue dans le gestionnaire de tâches Cli');
    print('Tapez "help" pour a liste des commandes ou "quit" pour quiter');

    while (true) {
      stdout.write('>');
      final String? input = stdin.readLineSync();

      if (input == null) {
        print('Fin de la session \n');
        break;
      }
      final (commandType, args) = _parseCommand(input);

      if (commandType == CommandType.quit) {
        print('\nFin de la session');
        break;
      }
      _handleCommand(commandType, args);
    }
  }

  (CommandType, List<String>) _parseCommand(String input) {
    final parts = input.trim().toLowerCase().split(' ');

    return switch (parts) {
      ['quit'] => (CommandType.quit, <String>[]),
      ['help'] => _showHelp(),
      ['list'] => (CommandType.list, <String>[]),
      ['create', var title] => (CommandType.create, [title]),
      ['complete', var id] => (CommandType.complete, [id]),
      ['delete', var id] => (CommandType.delete, [id]),
      _ => (CommandType.unknown, parts),
    };
  }

  void _handleCommand(CommandType type, List<String> args) {
    switch (type) {
      case CommandType.help:
        break;

      case CommandType.list:
        _listTask();
        break;

      case CommandType.create:
        if (args.isNotEmpty) {
          _createTask(args.first);
        }
        break;

      case CommandType.complete:
        if (args.isNotEmpty) {
          _completeTask(args.first);
        }
        break;

      case CommandType.delete:
        if (args.isNotEmpty) {
          _deleteTask(args.first);
        }
        break;

      case CommandType.quit:
        break;

      case CommandType.unknown:
        break;
    }
  }

  void _listTask() {
    final tasks = _service.listTasks();

    if (tasks.isEmpty) {
      print('Aucune Tâche disponible');
    }

    for (final task in tasks) {
      final status = task.isComplete ? '[x]' : '[ ]';
      print('$status - ${task.title}   (${task.priority.name})');
    }
  }

  void _createTask(String title) {
    try {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      );

      _service.addTask(task);
      print('La tâche "$title" a été créée avec succès');
    } catch (e) {
      print('Erreur lors de la création de la tâche: $e');
    }
  }

  void _completeTask(String id) {
    try {
      final tasks = _service.listTasks();
      final task = tasks.firstWhere((t) => t.id == id);

      task.complete();

      _service.addTask(task);
      print('La tâche "${task.title}" a été terminée avec succès.');
    } catch (e) {
      print('Erreur: Impossible de terminer la tâche $id');
    }
  }

  void _deleteTask(String id) {
    try {
      final tasks = _service.listTasks();
      final updatedTasks = tasks.where((t) => t.id != id).toList();

      if (tasks.length == updatedTasks.length) {
        print('Erreur: Aucune tâche trouvée avec l\'idée $id');
      }

      _service.saveTasks(updatedTasks);
    } catch (e) {
      print('Erreur lors de la suppression: $e');
    }
  }

  (CommandType, List<String>) _showHelp() {
    print('''
Commandes disponibles:
    list                - Affiche la liste des tâches
    create <titre>      - Crée une nouvelle tâche
    complete <id>       - Marque la tâche comme terminée
    delete <id>         - Supprime la tâche
    help                - Affiche cette aide
    quit                - Quite l'application
    ''');

    return (CommandType.unknown, <String>[]);
  }
}
