// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sgames/tic_tac_toe/data/variables_and_constants.dart';
import 'package:sgames/tic_tac_toe/engine/game_engine.dart';
import 'package:sgames/tic_tac_toe/presentation/widgets/quit_dialog_w.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late GameEngine gameEngine;

  @override
  void initState() {
    super.initState();
    gameEngine = GameEngine();
  }

  void _resetGame() {
    setState(() {
      gameEngine = GameEngine();
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
          title: Text('Tic Tac Toe Board'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt),
              color: Colors.white,
              onPressed: _resetGame,
            ),
          ],
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
                              if (gameEngine.makeMove(index)) {
                                setState(() {
                                  // Update the UI after a move
                                });
                              }
                              if (gameEngine.board.every(
                                    (el) => el.isNotEmpty,
                                  ) &&
                                  gameEngine.winner.isEmpty) {
                                Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () {
                                    _showDialog(context, "Match Draw!!!");
                                  },
                                );
                              }
                              if (gameEngine.winner.isNotEmpty) {
                                Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () {
                                    _showDialog(
                                      context,
                                      '${gameEngine.winner} wins!',
                                    );
                                  },
                                );
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
