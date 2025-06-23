import 'package:flutter/material.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/tutorial_card.dart';

// Tutorial Page
class TicTacToeTutorialPage extends StatelessWidget {
  const TicTacToeTutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Tic Tac Toe'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2), Color(0xFFa8b8ff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TutorialCard(
              title: '🎯 Objective',
              description:
                  'Be the first player to get three of your marks (X or O) in a row, column, or diagonal.',
            ),
            TutorialCard(
              title: '🎮 Game Setup',
              description:
                  'The game is played on a 3x3 grid. Player 1 uses X marks, Player 2 uses O marks.',
            ),
            TutorialCard(
              title: '🔢 Taking Turns',
              description:
                  'Player X always goes first. Players take turns placing their mark in an empty square by tapping on it.',
            ),
            TutorialCard(
              title: '🏆 How to Win',
              description: '''You win by getting three of your marks in a row:
- Horizontally (across any row)
- Vertically (down any column)  
- Diagonally (corner to corner)''',
            ),
            TutorialCard(
              title: '🤝 Draw/Tie',
              description:
                  'If all 9 squares are filled and no player has three in a row, the game ends in a draw.',
            ),
            TutorialCard(
              title: '🔄 New Game',
              description:
                  'After each game ends, you can start a new game. The winner of the previous game goes first.',
            ),
            TutorialCard(
              title: '💡 Strategy Tips',
              description: '''- Try to get the center square first
- Block your opponent from getting three in a row
- Look for opportunities to create two ways to win at once''',
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5a67d8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Or Navigator.push to game screen
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Game'),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
