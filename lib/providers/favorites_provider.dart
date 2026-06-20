import 'package:flutter/foundation.dart';

import '../models/character.dart';
import '../services/favorites_storage.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesStorage _storage = FavoritesStorage();
  final List<Character> _favorites = [];

  List<Character> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(int characterId) {
    return _favorites.any((character) => character.id == characterId);
  }

  Future<void> loadFavorites() async {
    _favorites
      ..clear()
      ..addAll(await _storage.load());
    notifyListeners();
  }

  Future<void> toggle(Character character) async {
    if (isFavorite(character.id)) {
      _favorites.removeWhere((item) => item.id == character.id);
    } else {
      _favorites.add(character);
    }
    await _storage.save(_favorites);
    notifyListeners();
  }
}
