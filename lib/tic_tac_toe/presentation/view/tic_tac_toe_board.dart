// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// This file contails the Tic Tac Toe board UI and game logic.
// It manages the game state, player turns, and integrates with the AI for computer mode.

import 'package:flutter/material.dart';
import 'package:sgames/tic_tac_toe/engine/game_mode.dart';
import 'package:sgames/tic_tac_toe/ai/tic_tac_toe_ai.dart';
import 'package:sgames/tic_tac_toe/engine/game_engine.dart';
import 'package:sgames/tic_tac_toe/data/variables_and_constants.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/quit_dialog_w.dart';

class TicTacToeBoard extends StatefulWidget {
  final String gameMode;

  const TicTacToeBoard({super.key, required this.gameMode});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late GameEngine gameEngine;
  late TicTacToeAi? gameAi;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Create the game engine first
    gameEngine = GameEngine(
      board: List.filled(9, ""),
      currentPlayer: cross,
      winner: empty,
      gameMode: widget.gameMode,
      humanPlayer: cross,
    );

    // Set the game mode
    if (widget.gameMode == GameMode.playWithComputer) {
      gameEngine.setGameMode(GameMode.playWithComputer);
      // Create AI after gameEngine is set up
      gameAi = TicTacToeAi(gameEngine: gameEngine);
    } else {
      gameEngine.setGameMode(GameMode.passAndPlay);
      gameAi = null; // Clear AI reference for pass and play
    }
  }

  void _resetGame() {
    setState(() {
      // Reset the game engine properties instead of creating new instance
      gameEngine.board = List.filled(9, "");
      gameEngine.currentPlayer = cross;
      gameEngine.winner = empty;

      // Keep the same gameEngine instance so AI reference remains valid
      // Only recreate AI if it's computer mode and AI doesn't exist
      if (widget.gameMode == GameMode.playWithComputer && gameAi == null) {
        gameAi = TicTacToeAi(gameEngine: gameEngine);
      }
    });

    // If it's computer mode and computer goes first, make the first move
    if (widget.gameMode == GameMode.playWithComputer &&
        gameEngine.currentPlayer != gameEngine.humanPlayer) {
      _makeComputerMove();
    }
  }

  // Helper method to check if game has ended
  bool _checkGameEnd() {
    // Check for draw
    if (gameEngine.board.every((el) => el.isNotEmpty) &&
        gameEngine.winner.isEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _showDialog(context, "Match Draw!!!");
      });
      return true;
    }

    // Check for winner
    if (gameEngine.winner.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _showDialog(context, '${gameEngine.winner} wins!');
      });
      return true;
    }

    return false;
  }

  // Computer move logic
  void _makeComputerMove() {
    // Add a delay to make it feel more natural
    Future.delayed(const Duration(milliseconds: 500), () {
      if (gameEngine.winner.isEmpty &&
          !gameEngine.board.every((el) => el.isNotEmpty)) {
        int computerMoveIndex = gameAi!.getComputerMoveIndex();

        if (gameEngine.makeMove(computerMoveIndex)) {
          setState(() {
            // Update UI after computer move
          });

          // Check for game end after computer move
          _checkGameEnd();
        }
      }
    });
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  Widget _getMatchText(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.deepPurple.shade700,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        final shouldPop = await QuitDialogW.show(context);
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double boardSize = constraints.maxWidth;
              double tileSize = boardSize / 3;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "${gameEngine.currentPlayer == cross ? cross : roll}'s Turn",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.brown[800]),
                      width: boardSize,
                      height: boardSize,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          int row = index ~/ 3;
                          int col = index % 3;
                          bool isLastRow = row == 2;
                          bool isLastCol = col == 2;
                          return GestureDetector(
                            onTap: () {
                              // Player makes their move
                              if (gameEngine.makeMove(index)) {
                                setState(() {
                                  // Update the UI after player move
                                });

                                // Check for game end after player move
                                if (_checkGameEnd()) {
                                  return; // Exit if game ended
                                }

                                // If playing with computer and it's computer's turn, make computer move
                                if (gameEngine.gameMode ==
                                        GameMode.playWithComputer &&
                                    gameEngine.currentPlayer !=
                                        gameEngine.humanPlayer) {
                                  _makeComputerMove();
                                }
                              }
                            },
                            child: Container(
                              width: tileSize,
                              height: tileSize,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                border: Border(
                                  right: isLastCol
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          width: 3,
                                        ),
                                  bottom: isLastRow
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          width: 3,
                                        ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  gameEngine.board[index],
                                  style: TextStyle(
                                    fontSize: 48,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    _getMatchText(
                      widget.gameMode == GameMode.playWithComputer
                          ? "🧠 Human vs AI Match 🤖"
                          : "🧠 Human vs Human Match 🧠",
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _resetGame,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
