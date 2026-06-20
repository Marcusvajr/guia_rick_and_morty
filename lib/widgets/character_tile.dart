import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';
import '../providers/favorites_provider.dart';
import '../screens/character_detail_screen.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(character.id);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFDFF7D7),
          backgroundImage: NetworkImage(character.image),
          radius: 30,
        ),
        title: Text(
          character.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${character.localizedStatus} - ${character.localizedSpecies}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          tooltip: isFavorite ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? const Color(0xFFE83E8C) : const Color(0xFF276749),
          onPressed: () => favorites.toggle(character),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CharacterDetailScreen(character: character),
            ),
          );
        },
      ),
    );
  }
}
