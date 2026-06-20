import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';
import '../widgets/character_tile.dart';
import '../widgets/empty_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: favorites.isEmpty
          ? const EmptyState(
              icon: Icons.favorite_border,
              title: 'Nenhum favorito',
              message: 'Adicione personagens tocando no coração da lista.',
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return CharacterTile(character: favorites[index]);
              },
            ),
    );
  }
}
