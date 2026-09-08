import 'dart:convert';
import 'dart:io';
import 'package:task_manager_cli/src/models/task.dart';
import 'task_repository.dart';

/// Implémentation persistant via fichier JSON.
final class JsonTaskRepository implements TaskRepository {
  JsonTaskRepository(this._filePath);

  final String _filePath;

  @override
  Future<List<Task>> loadTasks() async {
    final file = File(_filePath);

    // Si le fichier n'existe pas, on retourne une liste vide (premier lancement).
    if (!await file.exists()) {
      return <Task>[];
    }

    try {
      final String jsonString = await file.readAsString();
      final dynamic decoded = jsonDecode(jsonString);

      // Utilisation du pattern matching (Module 1.13) pour valider la structure de données
      if (decoded is List<Object?>) {
        // On transforme chaque élément du JSON en objet Task
        return decoded
            .map((item) => Task.fromJson(item as Map<String, Object?>))
            .toList();
      } else {
        throw const FormatException('Le fichier JSON doit contenir une liste.');
      }
    } on Object {
      // Pour l'instant, on relance l'erreur. La gestion fine sera faite à l'étape 6 (Erreurs).
      rethrow;
    }
  }

  // lib/src/repositories/json_task_repository.dart

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final file = File(_filePath);

    // Créer le dossier s'il n'existe pas
    await file.parent.create(recursive: true);

    // Convertir la liste en JSON
    final List<Map<String, Object?>> jsonList = tasks
        .map((task) => task.toJson())
        .toList();

    // Écrire dans le fichier
    await file.writeAsString(jsonEncode(jsonList));
  }
}
