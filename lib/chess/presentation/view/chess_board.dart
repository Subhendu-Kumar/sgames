// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sgames/chess/engine/move.dart';
import 'package:sgames/chess/engine/game_state.dart';
import 'package:sgames/chess/data/variables_and_constants.dart';
import 'package:sgames/chess/presentation/widgets/quit_dialog_w.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  GameState gameState = GameState();

  int? selectedRow;
  int? selectedCol;
  List<Move> validMoves = [];

  Widget _getPieceImage(String piece, double size) {
    if (piece == blank) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/$piece.png',
        width: size * 0.8,
        height: size * 0.8,
        fit: BoxFit.contain,
      ),
    );
  }

  bool _isCurrentPlayerPiece(String piece) {
    if (piece == blank) return false;
    bool isPieceWhite = piece == white && piece != black;
    return isPieceWhite == gameState.whiteTurn;
  }

  void _clearSelection() {
    selectedRow = null;
    selectedCol = null;
    validMoves = [];
  }

  void _resetGame() {
    setState(() {
      gameState = GameState();
      _clearSelection();
    });
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 227, 193, 180),
              Color(0xFF8D6E63),
              Color.fromARGB(255, 147, 98, 83),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Chess Master',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.restart_alt),
                color: Colors.white,
                onPressed: _resetGame,
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                color: Colors.white,
                onPressed: gameState.moveLog.isEmpty
                    ? null
                    : () {
                        setState(() {
                          gameState.undoMove();
                          _clearSelection();
                        });
                      },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double boardSize = constraints.maxWidth;
                double tileSize = boardSize / 8;
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
                          gradient: LinearGradient(
                            colors: gameState.whiteTurn
                                ? [
                                    const Color.fromARGB(255, 185, 184, 184),
                                    Colors.grey.shade200,
                                  ]
                                : [Colors.grey.shade800, Colors.black],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: gameState.whiteTurn
                                ? Colors.black.withOpacity(0.2)
                                : Colors.white.withOpacity(0.2),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          "${gameState.whiteTurn ? 'White' : 'Black'}'s Turn",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: gameState.whiteTurn
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: boardSize,
                          height: boardSize,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 64,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  childAspectRatio: 1,
                                ),
                            itemBuilder: (context, index) {
                              int row = index ~/ 8;
                              int col = index % 8;
                              String piece = gameState.board[row][col];
                              bool isWhiteTile = (row + col) % 2 == 0;
                              bool isSelected =
                                  row == selectedRow && col == selectedCol;
                              bool isValidMoveTarget = validMoves.any(
                                (move) =>
                                    move.toRow == row && move.toCol == col,
                              );
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedRow == null) {
                                      // Try to select a piece
                                      if (piece != blank &&
                                          _isCurrentPlayerPiece(piece[0])) {
                                        selectedRow = row;
                                        selectedCol = col;
                                        validMoves = gameState
                                            .getValidMoves()
                                            .where(
                                              (move) =>
                                                  move.fromRow == row &&
                                                  move.fromCol == col,
                                            )
                                            .toList();
                                      }
                                    } else if (selectedRow == row &&
                                        selectedCol == col) {
                                      // Clicking on already selected piece - deselect
                                      _clearSelection();
                                    } else {
                                      // Attempt to move
                                      Move attemptedMove = Move(
                                        fromRow: selectedRow!,
                                        fromCol: selectedCol!,
                                        toRow: row,
                                        toCol: col,
                                        board: gameState.board,
                                      );

                                      // Check if attempted move is valid
                                      List<Move> allValidMoves = gameState
                                          .getValidMoves();
                                      bool isValid = allValidMoves.any(
                                        (move) =>
                                            move.fromRow ==
                                                attemptedMove.fromRow &&
                                            move.fromCol ==
                                                attemptedMove.fromCol &&
                                            move.toRow == attemptedMove.toRow &&
                                            move.toCol == attemptedMove.toCol,
                                      );

                                      if (isValid) {
                                        gameState.makeMove(attemptedMove);
                                        _clearSelection();
                                      } else {
                                        // Invalid move - try to select the clicked piece if it belongs to current player
                                        if (piece != blank &&
                                            _isCurrentPlayerPiece(piece)) {
                                          selectedRow = row;
                                          selectedCol = col;
                                          validMoves = gameState
                                              .getValidMoves()
                                              .where(
                                                (move) =>
                                                    move.fromRow == row &&
                                                    move.fromCol == col,
                                              )
                                              .toList();
                                        } else {
                                          _clearSelection();
                                        }
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  width: tileSize,
                                  height: tileSize,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.greenAccent.withOpacity(0.6)
                                        : isValidMoveTarget
                                        ? Colors.yellowAccent.withOpacity(0.6)
                                        : isWhiteTile
                                        ? Colors.brown[100]
                                        : Colors.brown[700],
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Center(
                                    child: _getPieceImage(piece, tileSize),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
