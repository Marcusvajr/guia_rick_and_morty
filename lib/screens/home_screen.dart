import 'package:flutter/material.dart';

import 'character_list_screen.dart';
import 'favorites_screen.dart';
import 'location_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia Rick and Morty')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Explore personagens, locais e favoritos da Rick and Morty API.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          _HomeAction(
            icon: Icons.people,
            title: 'Personagens',
            subtitle: 'Lista paginada com detalhes e favoritos.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CharacterListScreen()),
            ),
          ),
          _HomeAction(
            icon: Icons.public,
            title: 'Locais',
            subtitle: 'Dimensões, tipos e residentes.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LocationListScreen()),
            ),
          ),
          _HomeAction(
            icon: Icons.favorite,
            title: 'Favoritos',
            subtitle: 'Personagens salvos no aparelho.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeAction extends StatelessWidget {
  const _HomeAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
