import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/task_repository.dart';

final class TaskService {
  final TaskRepository _repository;

  TaskService({required this._repository});

  List<Task> listTasks() {
    return _repository.loadTasks();
  }

  void addTask(Task task) {
    final currentTasks = _repository.loadTasks();
    final updatedTasks = [...currentTasks, task];

    _repository.saveTasks(updatedTasks);
  }

  void saveTasks(List<Task> tasks) {
    _repository.saveTasks(tasks);
  }
}
