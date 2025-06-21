import 'package:sgames/chess/data/variables_and_constants.dart';

class Move {
  final int fromRow;
  final int fromCol;
  final int toRow;
  final int toCol;
  final List<List<String>> board;
  final String movedPiece;
  final String capturedPiece;

  Move({
    required this.fromRow,
    required this.fromCol,
    required this.toRow,
    required this.toCol,
    required this.board,
  }) : movedPiece = board[fromRow][fromCol],
       capturedPiece = board[toRow][toCol];

  String get notation {
    String from = '${String.fromCharCode(97 + fromCol)}${8 - fromRow}';
    String to = '${String.fromCharCode(97 + toCol)}${8 - toRow}';
    String capture = capturedPiece != blank ? 'x' : '';
    return '$from$capture$to';
  }

  @override
  String toString() {
    return 'Move: $movedPiece from ($fromRow,$fromCol) to ($toRow,$toCol)${capturedPiece != blank ? ' capturing $capturedPiece' : ''}';
  }
}
