import 'package:flutter/material.dart';
import 'package:sgames/chess/presentation/widgets/tutorial_card.dart';

class ChessTutorialPage extends StatelessWidget {
  const ChessTutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Chess'),
        backgroundColor: const Color(0xFF5D4037),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5D4037), Color(0xFF8D6E63), Color(0xFFD7CCC8)],
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
                  'Checkmate the opponent\'s king while protecting your own.',
            ),
            TutorialCard(
              title: '♟️ Pieces & Movement',
              description:
                  '''- Pawn: Moves forward 1 square (2 on first move), captures diagonally.\n- Rook: Straight lines (horizontal/vertical).\n- Bishop: Diagonals.\n- Knight: L-shape (2+1).\n- Queen: Any direction.\n- King: One square in any direction.''',
            ),
            TutorialCard(
              title: '🔢 Turns',
              description: 'White moves first. Players alternate turns.',
            ),
            TutorialCard(
              title: '✅ Valid Moves',
              description:
                  'Only valid moves are allowed. You can tap a piece to view its available moves.',
            ),
            TutorialCard(
              title: '🔄 Undo',
              description:
                  'Use the undo button to go back one move (if available).',
            ),
            TutorialCard(
              title: '🏁 Game Over',
              description: 'The game ends in checkmate, stalemate, or draw.',
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D4C41),
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
