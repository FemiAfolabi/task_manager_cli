import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/task_repository.dart';

final class MemoryTaskRepository implements TaskRepository {
  final List<Task> _tasks;

  MemoryTaskRepository([List<Task> initialTasks = const <Task>[]])
    : _tasks = [...initialTasks];

  @override
  List<Task> loadTasks() {
    return List<Task>.unmodifiable(_tasks);
  }

  @override
  void saveTasks(List<Task> tasks) {
    _tasks
      ..clear()
      ..addAll(tasks);
  }
}
