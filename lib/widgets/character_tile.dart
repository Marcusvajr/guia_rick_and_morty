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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
          radius: 28,
        ),
        title: Text(character.name),
        subtitle: Text('${character.localizedStatus} - ${character.species}'),
        trailing: IconButton(
          tooltip: isFavorite ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? Colors.red : null,
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
