import 'package:flutter/material.dart';
import 'package:sgames/chess/engine/move.dart';
import 'package:sgames/chess/engine/game_state.dart';
import 'package:sgames/chess/data/variables_and_constants.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  GameState gameState = GameState();

  int? selectedRow;
  int? selectedCol;

  Widget _getPieceImage(String piece, double size) {
    if (piece == blank) return const SizedBox();
    return Image.asset(
      'assets/images/$piece.png',
      width: size * 0.8,
      height: size * 0.8,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Board'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: gameState.moveLog.isEmpty
                ? null
                : () {
                    setState(() {
                      gameState.undoMove();
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
              child: SizedBox(
                width: boardSize,
                height: boardSize,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    String piece = gameState.board[row][col];
                    bool isWhiteTile = (row + col) % 2 == 0;
                    bool isSelected = row == selectedRow && col == selectedCol;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedRow == null && piece != blank) {
                            selectedRow = row;
                            selectedCol = col;
                          } else if (selectedRow != null) {
                            gameState.makeMove(
                              Move(
                                fromRow: selectedRow!,
                                fromCol: selectedCol!,
                                toRow: row,
                                toCol: col,
                                board: gameState.board,
                              ),
                            );
                            selectedRow = null;
                            selectedCol = null;
                          }
                        });
                      },
                      child: Container(
                        width: tileSize,
                        height: tileSize,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.greenAccent
                              : isWhiteTile
                              ? Colors.brown[100]
                              : Colors.brown[700],
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Center(child: _getPieceImage(piece, tileSize)),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
