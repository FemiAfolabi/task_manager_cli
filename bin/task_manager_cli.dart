import 'package:task_manager_cli/src/cli/task_command_handler.dart';
import 'package:task_manager_cli/src/repositories/json_task_repository.dart';
import 'package:task_manager_cli/src/services/task_service.dart';

Future<void> main() async {
  _displayHeader();

  final repository = JsonTaskRepository('data/tasks.json');
  final service = TaskService(repository: repository);
  final handler = TaskCommandHandler(service: service);

  await handler.run();
}

void _displayHeader() {
  print('============================================');
  print('     GESTIONNAIRE DE TACHES CLI AVANCÉ');
  print('      Flutter Engineering Academy S1');
  print('============================================');
  print('');
}
