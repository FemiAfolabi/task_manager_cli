import 'package:task_manager_cli/src/task_actions.dart';
import 'package:test/test.dart';

void main() {
  test('normalizeTaskTitle retire les espaces extérieurs', () {
    final String result = normalizedTaskTitle(' Lire Dart ');
    expect(result, 'Lire Dart');
  });
  test('matchesKeyword accepte un mot-clé présent', () {
    final bool result = matchesKeyword(
      title: 'Étudier les fonctions',
      keyword: 'fonctions',
    );
    expect(result, isTrue);
  });
}
