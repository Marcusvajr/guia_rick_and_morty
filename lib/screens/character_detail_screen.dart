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
            color: isFavorite ? const Color(0xFFE83E8C) : null,
            onPressed: () => favorites.toggle(character),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF8E4), Color(0xFFF8FFF6)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 820;

            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 16,
                vertical: 18,
              ),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1040),
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _CharacterImage(character: character)),
                              const SizedBox(width: 28),
                              Expanded(child: _CharacterInfo(character: character)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _CharacterImage(character: character),
                              const SizedBox(height: 20),
                              _CharacterInfo(character: character),
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

class _CharacterImage extends StatelessWidget {
  const _CharacterImage({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showImageModal(context, character),
        child: Container(
          color: const Color(0xFFDDF7D3),
          padding: const EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: 'character-${character.id}',
              child: Image.network(
                character.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 72);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImageModal(BuildContext context, Character character) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.black.withValues(alpha: 0.92),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Hero(
                    tag: 'character-${character.id}',
                    child: Image.network(
                      character.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton.filled(
                  tooltip: 'Fechar',
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F5127),
                  ),
            ),
            const SizedBox(height: 16),
            _InfoChip(
              icon: Icons.favorite,
              label: 'Status',
              value: character.localizedStatus,
            ),
            _InfoChip(
              icon: Icons.category,
              label: 'Espécie',
              value: character.localizedSpecies,
            ),
            _InfoChip(
              icon: Icons.person,
              label: 'Gênero',
              value: character.localizedGender,
            ),
            _InfoChip(
              icon: Icons.travel_explore,
              label: 'Origem',
              value: character.origin,
            ),
            _InfoChip(
              icon: Icons.place,
              label: 'Localização',
              value: character.location,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FAEA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD0EDC8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF23A455), size: 22),
          const SizedBox(width: 10),
          SizedBox(
            width: 104,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? 'Desconhecido' : value)),
        ],
      ),
    );
  }
}
