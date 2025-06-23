import 'package:sgames/chess/data/variables_and_constants.dart';

// This class represents a move in a chess game, including the starting and ending positions,
// the board state, and the pieces involved in the move.
class Move {
  final int fromRow;
  final int fromCol;
  final int toRow;
  final int toCol;
  final List<List<String>> board;
  final String movedPiece;
  final String capturedPiece;
  late bool isPawnPromotion;

  // Constructor to initialize the move with the starting and ending positions,
  // the board state, and the pieces involved in the move.
  Move({
    required this.fromRow,
    required this.fromCol,
    required this.toRow,
    required this.toCol,
    required this.board,
  }) : movedPiece = board[fromRow][fromCol],
       capturedPiece = board[toRow][toCol] {
    isPawnPromotion =
        (movedPiece == whitePawn && toRow == 0) ||
        (movedPiece == blackPawn && toRow == 7);
  }

  // Returns the notation for the move in algebraic chess notation
  // e.g., "e2e4" for moving a piece from e2 to e4,
  // or "e2xe4" if a piece is captured.
  String get notation {
    String from = '${String.fromCharCode(97 + fromCol)}${8 - fromRow}';
    String to = '${String.fromCharCode(97 + toCol)}${8 - toRow}';
    String capture = capturedPiece != blank ? 'x' : '';
    return '$from$capture$to';
  }

  // Returns a string representation of the move for debugging purposes
  // e.g., "Move: Pawn from (1,0) to (3,0) capturing Knight"
  // or "Move: Pawn from (1,0) to (3,0)"
  @override
  String toString() {
    return 'Move: $movedPiece from ($fromRow,$fromCol) to ($toRow,$toCol)${capturedPiece != blank ? ' capturing $capturedPiece' : ''}';
  }
}
