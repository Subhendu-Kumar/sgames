import 'package:flutter/material.dart';
import 'package:sgames/core/view/about_page.dart';
import 'package:sgames/core/widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onGameSelected;
  final List<Map<String, dynamic>> games = [
    {
      'title': 'Chess',
      'description': 'Play the classic strategy game.',
      'icon': Icons.sports_esports,
      'route': 1,
    },
    {
      'title': 'Tic Tac Toe',
      'description': 'Quick and fun 2-player game.',
      'icon': Icons.grid_on,
      'route': 2,
    },
  ];

  HomeScreen({super.key, this.onGameSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Color.lerp(
                Theme.of(context).colorScheme.inversePrimary,
                Colors.brown.shade400,
                0.5,
              )!,
              Colors.brown.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to SGames!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose a game and start playing!',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return GameCard(
                        title: game['title'],
                        description: game['description'],
                        icon: game['icon'],
                        onTap: () {
                          onGameSelected?.call(game['route'] as int);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutPage()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.info),
      ),
    );
  }
}
