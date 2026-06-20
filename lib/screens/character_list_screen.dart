import 'package:flutter/material.dart';

import '../models/character.dart';
import '../services/rick_and_morty_api.dart';
import '../widgets/character_tile.dart';
import '../widgets/error_message.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final _api = RickAndMortyApi();
  final _controller = ScrollController();
  final List<Character> _characters = [];

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
      final page = await _api.fetchCharacters(page: _nextPage!);
      if (!mounted) return;
      setState(() {
        _characters.addAll(page.items);
        _nextPage = page.nextPage;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = 'Não foi possível carregar personagens.');
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
    if (_characters.isEmpty && _isLoading) {
      return const Scaffold(
        appBar: _CharactersAppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_characters.isEmpty && _error != null) {
      return Scaffold(
        appBar: const _CharactersAppBar(),
        body: ErrorMessage(message: _error!, onRetry: _loadNextPage),
      );
    }

    return Scaffold(
      appBar: const _CharactersAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _characters.clear();
            _nextPage = 1;
          });
          await _loadNextPage();
        },
        child: ListView.builder(
          controller: _controller,
          itemCount: _characters.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= _characters.length) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return CharacterTile(character: _characters[index]);
          },
        ),
      ),
    );
  }
}

class _CharactersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CharactersAppBar();

  @override
  Widget build(BuildContext context) => AppBar(title: const Text('Personagens'));

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
