// This file contains the About dialog for the Tic Tac Toe game, providing information about the game features and development.

import 'package:flutter/material.dart';

class AboutDialogW extends StatelessWidget {
  const AboutDialogW({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AboutDialogW(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Tic Tac Toe Game'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('A classic Flutter tic tac toe game with:'),
          SizedBox(height: 10),
          Text('• Interactive 3x3 game board'),
          Text('• Two-player gameplay (X vs O)'),
          Text('• Win detection and scoring'),
          Text('• Game reset functionality'),
          Text('• Clean and intuitive interface'),
          Text('• Responsive touch controls'),
          SizedBox(height: 15),
          Text('Developed with Flutter'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
