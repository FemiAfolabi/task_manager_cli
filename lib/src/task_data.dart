typedef TaskData = Map<String, Object?>;

final sampleTasks = <TaskData>[
  <String, Object?>{
    'title': 'Réviser les collections',
    'priority': 3,
    'completed': false,
    'tags': <String>['dart', 'CLI'],
  },
  <String, Object?>{
    'title': 'Mettre à jour le README',
    'priority': 1,
    'completed': true,
    'tags': <String>['documentation'],
  },
];
