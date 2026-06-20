import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider()..loadFavorites(),
      child: const RickAndMortyApp(),
    ),
  );
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF23C552),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Guia Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3FAEF),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFECF8E8),
          foregroundColor: Color(0xFF1F2A1F),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF23C552),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
