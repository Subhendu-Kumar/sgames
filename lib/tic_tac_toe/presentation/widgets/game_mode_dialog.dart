// ignore_for_file: deprecated_member_use

// This file contains the Game Mode Dialog for Tic Tac Toe, allowing users to select between different game modes.

import 'package:flutter/material.dart';
import 'package:sgames/tic_tac_toe/engine/game_mode.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/game_mode_button.dart';

class GameModeDialog extends StatefulWidget {
  const GameModeDialog({super.key});

  @override
  State<GameModeDialog> createState() => _GameModeDialogState();
}

class _GameModeDialogState extends State<GameModeDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 320,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepPurple.shade200,
                      Colors.deepPurple.shade400,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title with icon
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.grid_on,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Choose Game Mode',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Select how you want to play',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Pass n Play Button
                    GameModeButton(
                      icon: Icons.people,
                      title: 'Pass n Play',
                      subtitle: 'Play with friends locally',
                      colors: [
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade600,
                      ],
                      onTap: () {
                        Navigator.of(context).pop(GameMode.passAndPlay);
                      },
                    ),
                    SizedBox(height: 16),
                    // Play with Computer Button
                    GameModeButton(
                      icon: Icons.computer,
                      title: 'Play with Computer',
                      subtitle: 'Challenge the AI',
                      colors: [
                        Colors.deepPurple.shade500,
                        Colors.deepPurple.shade300,
                      ],
                      onTap: () {
                        Navigator.of(context).pop(GameMode.playWithComputer);
                      },
                    ),
                    SizedBox(height: 24),
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
