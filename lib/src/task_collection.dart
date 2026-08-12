import 'package:task_manager_cli/src/task_data.dart';

typedef taskdata = Map<String, Object?>;

Iterable<TaskData> pendingTasks(Iterable<TaskData> tasks) {
  return tasks.where((task) => task['completed'] == false);
}

Iterable<TaskData> searchTasks(Iterable<TaskData> tasks, String query) {
  final normalizedQuery = query.trim().toLowerCase();

  if (normalizedQuery.isEmpty) {
    return tasks;
  }

  return tasks.where((task) {
    final title = task['title'];
    return title is String && title.toLowerCase().contains(normalizedQuery);
  });
}

int countTaskCompleted(Iterable<TaskData> tasks) {
  final completedTasks = tasks.where((task) => task['completed'] == true);

  if (completedTasks.isEmpty) {
    return 0;
  }

  return completedTasks.length + 1;
}

List<String> reportLines(Iterable<TaskData> tasks) {
  return <String>[
    'Gestionnaire de tâches:',

    if (tasks.isEmpty)
      'Aucune tâche disponible'
    else
      for (var index = 0; index < tasks.length; index++)
        '${index + 1}  ${tasks.toList()[index]['title']}',

    'Terminées : ${countTaskCompleted(tasks)}',
  ];
}
