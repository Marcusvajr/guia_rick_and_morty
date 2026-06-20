import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/api_page.dart';
import '../models/character.dart';
import '../models/location_model.dart';

class RickAndMortyApi {
  RickAndMortyApi({http.Client? client}) : _client = client ?? http.Client();

  static const _baseUrl = 'https://rickandmortyapi.com/api';
  final http.Client _client;

  Future<ApiPage<Character>> fetchCharacters({int page = 1}) async {
    final json = await _getJson('$_baseUrl/character?page=$page');
    return ApiPage(
      items: (json['results'] as List)
          .map((item) => Character.fromJson(item as Map<String, dynamic>))
          .toList(),
      nextPage: _nextPageFromInfo(json['info'] as Map<String, dynamic>),
    );
  }

  Future<ApiPage<LocationModel>> fetchLocations({int page = 1}) async {
    final json = await _getJson('$_baseUrl/location?page=$page');
    return ApiPage(
      items: (json['results'] as List)
          .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      nextPage: _nextPageFromInfo(json['info'] as Map<String, dynamic>),
    );
  }

  Future<List<Character>> fetchCharactersByUrls(List<String> urls) async {
    final ids = urls
        .map((url) => Uri.parse(url).pathSegments.last)
        .where((id) => int.tryParse(id) != null)
        .toList();

    if (ids.isEmpty) return [];

    final decoded = await _getDecoded('$_baseUrl/character/${ids.join(',')}');
    if (decoded is List) {
      return decoded
          .map((item) => Character.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [Character.fromJson(decoded as Map<String, dynamic>)];
  }

  Future<Map<String, dynamic>> _getJson(String url) async {
    final decoded = await _getDecoded(url);
    return decoded as Map<String, dynamic>;
  }

  Future<dynamic> _getDecoded(String url) async {
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Erro ${response.statusCode} ao carregar dados.');
    }
    return jsonDecode(response.body);
  }

  int? _nextPageFromInfo(Map<String, dynamic> info) {
    final next = info['next'] as String?;
    if (next == null) return null;
    return int.tryParse(Uri.parse(next).queryParameters['page'] ?? '');
  }
}
