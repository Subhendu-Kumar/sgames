import 'package:sgames/chess/engine/move.dart';
import 'package:sgames/chess/data/variables_and_constants.dart';

class GameState {
  late List<List<String>> board;
  late List<Move> moveLog = [];

  GameState() {
    board = List<List<String>>.from(
      initialBoard.map((row) => List<String>.from(row)),
    );
  }

  void makeMove(Move move) {
    board[move.fromRow][move.fromCol] = blank;
    board[move.toRow][move.toCol] = move.movedPiece;
    moveLog.add(move);
  }

  void undoMove() {
    if (moveLog.isNotEmpty) {
      Move lastMove = moveLog.removeLast();
      board[lastMove.fromRow][lastMove.fromCol] = lastMove.movedPiece;
      board[lastMove.toRow][lastMove.toCol] = lastMove.capturedPiece;
    }
  }
}
