import 'package:flutter_test/flutter_test.dart';
import 'package:guia_rick_and_morty/models/character.dart';

void main() {
  test('creates character from API json', () {
    final character = Character.fromJson({
      'id': 1,
      'name': 'Rick Sanchez',
      'status': 'Alive',
      'species': 'Human',
      'gender': 'Male',
      'image': 'https://example.com/rick.png',
      'origin': {'name': 'Earth'},
      'location': {'name': 'Citadel of Ricks'},
    });

    expect(character.id, 1);
    expect(character.name, 'Rick Sanchez');
    expect(character.origin, 'Earth');
    expect(character.location, 'Citadel of Ricks');
  });
}
