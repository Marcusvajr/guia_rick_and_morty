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
          : LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth >= 820 ? 24 : 0,
                    vertical: 8,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: CharacterTile(character: favorites[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
