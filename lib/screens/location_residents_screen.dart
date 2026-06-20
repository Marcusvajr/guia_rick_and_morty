import 'package:flutter/material.dart';

import '../models/character.dart';
import '../models/location_model.dart';
import '../services/rick_and_morty_api.dart';
import '../widgets/character_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_message.dart';

class LocationResidentsScreen extends StatefulWidget {
  const LocationResidentsScreen({
    required this.location,
    super.key,
  });

  final LocationModel location;

  @override
  State<LocationResidentsScreen> createState() => _LocationResidentsScreenState();
}

class _LocationResidentsScreenState extends State<LocationResidentsScreen> {
  final _api = RickAndMortyApi();

  late Future<List<Character>> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.fetchCharactersByUrls(widget.location.residents);
  }

  void _retry() {
    setState(() {
      _future = _api.fetchCharactersByUrls(widget.location.residents);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.location.name)),
      body: FutureBuilder<List<Character>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ErrorMessage(
              message: 'Não foi possível carregar residentes.',
              onRetry: _retry,
            );
          }

          final residents = snapshot.data ?? const [];
          if (residents.isEmpty) {
            return const EmptyState(
              icon: Icons.person_off,
              title: 'Sem residentes',
              message: 'Este local não possui residentes cadastrados.',
            );
          }

          return ListView.builder(
            itemCount: residents.length,
            itemBuilder: (context, index) {
              return CharacterTile(character: residents[index]);
            },
          );
        },
      ),
    );
  }
}
