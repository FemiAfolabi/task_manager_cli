import 'package:task_manager_cli/src/models/task.dart';

abstract class TaskRepository {
  List<Task> loadTasks();

  void saveTasks(List<Task> tasks);
}
