// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sgames/chess/presentation/view/chess_tutorial_page.dart';
import 'package:sgames/core/utils/show_snackbar.dart';
import 'package:sgames/chess/presentation/view/chess_board.dart';
import 'package:sgames/chess/presentation/widgets/about_dialog_w.dart';
import 'package:sgames/chess/presentation/widgets/secondary_button.dart';

class ChessHomePage extends StatelessWidget {
  const ChessHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown[400]!,
              Colors.brown[600]!,
              Colors.brown[800]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Chess Icon/Logo
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
                child: Icon(
                  Icons.sports_esports,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Game Title
              Text(
                'CHESS',
                style: TextStyle(
                  fontSize: 64,
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
                'Master the Game of Kings',
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
                    MaterialPageRoute(builder: (context) => const ChessBoard()),
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
                    Icon(Icons.play_arrow, size: 32, color: Colors.brown[800]),
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
                          builder: (_) => const ChessTutorialPage(),
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
    );
  }
}
