import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../services/rick_and_morty_api.dart';
import '../widgets/error_message.dart';
import 'location_residents_screen.dart';

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  final _api = RickAndMortyApi();
  final _controller = ScrollController();
  final List<LocationModel> _locations = [];

  int? _nextPage = 1;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _loadNextPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || _nextPage == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final page = await _api.fetchLocations(page: _nextPage!);
      if (!mounted) return;
      setState(() {
        _locations.addAll(page.items);
        _nextPage = page.nextPage;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = 'Não foi possível carregar locais.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 300) {
      _loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_locations.isEmpty && _isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Locais')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_locations.isEmpty && _error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Locais')),
        body: ErrorMessage(message: _error!, onRetry: _loadNextPage),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Locais')),
      body: ListView.builder(
        controller: _controller,
        itemCount: _locations.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _locations.length) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final location = _locations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.public),
              title: Text(location.name),
              subtitle: Text('${location.type} - ${location.dimension}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LocationResidentsScreen(location: location),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
