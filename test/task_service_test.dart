import 'package:task_manager_cli/src/models/task.dart';
import 'package:task_manager_cli/src/repositories/memory_task_repository.dart';
import 'package:task_manager_cli/src/services/task_service.dart';
import 'package:test/test.dart';

void main() {
  group('TaskService', () {
    test('La tâche est créée correctement', () async {
      final repository = MemoryTaskRepository();
      final service = TaskService(repository: repository);

      final testTask = Task(id: 'task-001', title: 'Tâche de taste');

      await service.addTask(testTask);

      final tasks = await service.listTasks();
      expect(tasks.length, 1);
      expect(tasks.first.id, 'task-001');
    });
  });
}
