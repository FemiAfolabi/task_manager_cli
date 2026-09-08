import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/task_repository.dart';

final class TaskService {
  TaskService({required this._repository});
  final TaskRepository _repository;

  // Les méthodes deviennent asynchrones (Module 1.14)
  Future<List<Task>> listTasks() async {
    return await _repository.loadTasks();
  }

  Future<void> addTask(Task task) async {
    final currentTasks = await _repository.loadTasks();
    final updatedTasks = <Task>[...currentTasks, task];
    await _repository.saveTasks(updatedTasks);
  }

  // Nouvelle méthode pour mettre à jour une tâche sans recréer la liste entière
  Future<void> updateTask(Task updatedTask) async {
    final currentTasks = await _repository.loadTasks();
    final index = currentTasks.indexWhere((t) => t.id == updatedTask.id);

    if (index == -1) {
      throw ArgumentError('Tâche avec l\'ID ${updatedTask.id} introuvable.');
    }

    // Créer une nouvelle liste avec la tâche modifiée à la bonne position
    final updatedTasks = List<Task>.from(currentTasks);
    updatedTasks[index] = updatedTask;

    // SAUVEGARDER dans le fichier
    await _repository.saveTasks(updatedTasks);
  }

  Future<void> deleteTask(String title) async {
    final currentTasks = await _repository.loadTasks();
    final updatedTasks = currentTasks.where((t) => t.title != title).toList();
    if (currentTasks.length == updatedTasks.length) {
      throw ArgumentError('Aucune tâche avec cette id');
    }
    await _repository.saveTasks(updatedTasks);
  }
}
