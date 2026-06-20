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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAF8E4), Color(0xFFF9FFF6), Color(0xFFEAF5FF)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;

            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 16,
                vertical: 20,
              ),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F5127),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Guia Rick and Morty',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Explore personagens e locais do universo de Rick and Morty, veja residentes e salve seus favoritos.',
                                style: TextStyle(color: Color(0xFFE8FFE1)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        GridView.count(
                          crossAxisCount: isWide ? 3 : 1,
                          childAspectRatio: isWide ? 1.3 : 4.2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: [
                            _HomeAction(
                              color: const Color(0xFF23C552),
                              icon: Icons.people,
                              title: 'Personagens',
                              subtitle: 'Lista paginada com detalhes e favoritos.',
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CharacterListScreen(),
                                ),
                              ),
                            ),
                            _HomeAction(
                              color: const Color(0xFF31A8FF),
                              icon: Icons.public,
                              title: 'Locais',
                              subtitle: 'Dimensões, tipos e residentes.',
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const LocationListScreen(),
                                ),
                              ),
                            ),
                            _HomeAction(
                              color: const Color(0xFFE83E8C),
                              icon: Icons.favorite,
                              title: 'Favoritos',
                              subtitle: 'Personagens salvos no aparelho.',
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const FavoritesScreen(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HomeAction extends StatelessWidget {
  const _HomeAction({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
