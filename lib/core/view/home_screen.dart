import 'package:flutter/material.dart';
import 'package:sgames/core/widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
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

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00bbf9), Color(0xFF5a189a), Color(0xFF240046)],
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
                          DefaultTabController.of(
                            context,
                          ).animateTo(game['route']);
                          // Or if using `MainPage`, set selectedIndex with `Provider` or callback.
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
    );
  }
}
