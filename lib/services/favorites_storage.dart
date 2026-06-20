import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/character.dart';

class FavoritesStorage {
  static const _key = 'favorite_characters';

  Future<List<Character>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? const [];
    return raw
        .map((item) => Character.fromJson(jsonDecode(item) as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<Character> characters) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key,
      characters.map((character) => jsonEncode(character.toJson())).toList(),
    );
  }
}
