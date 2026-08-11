String normalizedTaskTitle(String rawTitle) {
  return rawTitle.trim();
}

bool isValideTaskTitle(String title) {
  return title.isNotEmpty;
}

String buildTaskSummary({
  required String title,
  required bool isCompleted,
  String? description,
}) {
  final String status = isCompleted ? 'Terminé' : 'En cours';
  final String details = description ?? 'Aucune description';
  return '[$title] $status - $details';
}

bool matchesKeyword({required String title, required String keyword}) {
  final String normaliezdTitle = title.toLowerCase();
  final String normalizedKeyword = keyword.trim().toLowerCase();

  if (normalizedKeyword.isEmpty) {
    return true;
  }

  return normaliezdTitle.contains(normalizedKeyword);
}
