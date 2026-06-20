import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';
import '../providers/favorites_provider.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(character.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => favorites.toggle(character),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              character.image,
              height: 280,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(character.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          _InfoRow(label: 'Status', value: character.localizedStatus),
          _InfoRow(label: 'Espécie', value: character.species),
          _InfoRow(label: 'Gênero', value: character.localizedGender),
          _InfoRow(label: 'Origem', value: character.origin),
          _InfoRow(label: 'Localização', value: character.location),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? 'Desconhecido' : value)),
        ],
      ),
    );
  }
}
