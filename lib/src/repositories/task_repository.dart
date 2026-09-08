import 'package:task_manager_cli/src/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> loadTasks();

  Future<void> saveTasks(List<Task> tasks);
}
