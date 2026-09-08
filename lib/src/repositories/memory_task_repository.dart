import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/task_repository.dart';

final class MemoryTaskRepository implements TaskRepository {
  final List<Task> _tasks;

  MemoryTaskRepository([List<Task> initialTasks = const <Task>[]])
    : _tasks = [...initialTasks];

  @override
  Future<List<Task>> loadTasks() {
    return Future<List<Task>>.value(List<Task>.unmodifiable(_tasks));
  }

  @override
  Future<void> saveTasks(List<Task> tasks) {
    _tasks
      ..clear()
      ..addAll(tasks);
    return Future<void>.value();
  }
}
