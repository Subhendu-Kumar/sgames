// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sgames/core/utils/show_snackbar.dart';
import 'package:sgames/tic_tac_toe/presentation/view/tic_tac_toe_board.dart';
import 'package:sgames/tic_tac_toe/presentation/view/tic_tac_toe_tutorial_page.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/about_dialog_w.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/secondary_button.dart';

class TicTacToeHomePage extends StatelessWidget {
  const TicTacToeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.grid_on, size: 100, color: Colors.white),
                ),
                const SizedBox(height: 40),
                // Game Title
                Text(
                  'TIC TAC TOE',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 8,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle
                Text(
                  'Challenge Your Mind',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 80),
                // Play Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicTacToeBoard(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.brown[800],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 32,
                        color: Colors.brown[800],
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'PLAY',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.brown[800],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Additional buttons (optional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Settings Button
                    SecondaryButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      onPressed: () =>
                          showSnackBar(context, "Settings coming soon!"),
                    ),
                    // Tutorial Button
                    SecondaryButton(
                      icon: Icons.school,
                      label: 'Tutorial',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TicTacToeTutorialPage(),
                          ),
                        );
                      },
                    ),
                    // About Button
                    SecondaryButton(
                      icon: Icons.info,
                      label: 'About',
                      onPressed: () {
                        AboutDialogW.show(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Footer
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
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
