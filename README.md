# Gestionnaire de tâche CLI avancé
Progrmmme Dart avancé, exécutable dans le terminal, pour gérer les tâches.

## Prérequis
- Dart SDK
- terminal
- Git

## Structure
- bin/task_manager_cli.dart : fichier Dart principal. L'exécution du programme commence ici.
- test/task_actions_test.dart
- pubspec.yaml : fichier de configuration principal du projet.
- README.md : fichier qui explique le programme.

## Exécution
```bash
dart dart pub get
```
```bash
dart run bin/task_manager_cli.dart
```

## Qualité
```bash
dart format .
```
```bash
dart analyze
```
```bash
dart test
```

## Etat actuel
Des fonctions de traitement des entrées comme le titre de la tâche, le statut, la description et le mot clé de recherche ont été implémentées.