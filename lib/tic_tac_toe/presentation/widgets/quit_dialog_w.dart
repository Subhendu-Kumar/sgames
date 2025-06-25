// This file contains the Quit Dialog for Tic Tac Toe, allowing users to confirm quitting the game.

import 'package:flutter/material.dart';

class QuitDialogW extends StatelessWidget {
  const QuitDialogW({super.key});

  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const QuitDialogW(),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quit Game'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure you want to quit the current game?'),
          SizedBox(height: 10),
          Text('Your progress will be lost.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Quit'),
        ),
      ],
    );
  }
}
