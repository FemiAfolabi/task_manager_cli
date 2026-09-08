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

  bool get isCompleted => _status == TaskStatus.completed;

  set status(TaskStatus newStattus) {
    if (_status != newStattus) {
      _status = newStattus;
    }
  }

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

  Task complete() {
    if (isCompleted) {
      throw StateError('La tâche $_title est déjà terminée');
    }
    return Task(
      id: id,
      title: title,
      description: description,
      priority: priority,
      status: TaskStatus.completed,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name,
      'status': status.name,
    };
  }

  factory Task.fromJson(Map<String, Object?> json) {
    try {
      final id = json['id'] as String;
      final title = json['title'] as String;
      final description = json['description'] as String?;
      final priorityName = json['priority'] as String? ?? 'medium';
      final statusName = json['statusd'] as String? ?? 'pending';

      return Task(
        id: id,
        title: title,
        description: description,
        priority: Priority.values.byName(priorityName),
        status: TaskStatus.values.byName(statusName),
      );
    } on Object catch (e) {
      throw FormatException('JSON non valide: $e');
    }
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, priority: ${priority.name}, status: ${status.name})';
  }
}
