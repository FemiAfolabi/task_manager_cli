import 'package:task_manager_cli/src/models/priority.dart';
import 'package:task_manager_cli/src/models/task_status.dart';

class Task {
  Task({
    required String id,
    required String title,
    this.description,
    this.priority = Priority.medium,
    this._status = TaskStatus.pending,
  }) : _id = _validateId(id),
       _title = _validateTitle(title);

  final String _id;
  String get id => _id;

  final String _title;
  String get title => _title;

  final String? description;

  final Priority priority;

  TaskStatus _status;
  TaskStatus get status => _status;

  bool get isComplete => _status == TaskStatus.completed;

  static String _validateId(String id) {
    final trimmed = id.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(id, 'id', 'l\'id ne peut pas être vide');
    }
    return trimmed;
  }

  static String _validateTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(
        title,
        'title',
        'le titre ne peut pas être vide',
      );
    }
    return trimmed;
  }

  void complete() {
    if (isComplete) {
      throw StateError('La tâche $_title est déjà terminée');
    }
    _status = TaskStatus.completed;
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, priority: ${priority.name}, status: ${status.name})';
  }
}
