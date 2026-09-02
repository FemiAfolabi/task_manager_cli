import 'dart:io';

void main() {
  _displayHeader();

  _displayHelp();
}

void _displayHeader() {
  print('============================================');
  print('     GESTIONNAIRE DE TACHES CLI AVANCÉ');
  print('      Flutter Engineering Academy S1');
  print('============================================');
  print('');
}

void _displayHelp() {
  print('Commandes simulées (disponible dans le module suivant) :');
  print('   - créer <titre>');
  print('   - lister');
  print('   - terminer <id>');
  print('   - supprimer <id>');
  print('   - quitter');
  print('');
  print('Appuyez sur entrée pour quitter');

  stdin.readLineSync();
}
