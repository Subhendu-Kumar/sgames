import 'package:sgames/chess/engine/move.dart';
import 'package:sgames/chess/data/variables_and_constants.dart';

class GameState {
  late List<List<String>> board;
  late List<Move> moveLog = [];
  late bool whiteTurn;

  GameState() {
    board = List<List<String>>.from(
      initialBoard.map((row) => List<String>.from(row)),
    );
    whiteTurn = true; // White starts the game
  }

  void makeMove(Move move) {
    board[move.fromRow][move.fromCol] = blank;
    board[move.toRow][move.toCol] = move.movedPiece;
    moveLog.add(move);
    whiteTurn = !whiteTurn; // Switch turn after a move
  }

  void undoMove() {
    if (moveLog.isNotEmpty) {
      Move lastMove = moveLog.removeLast();
      board[lastMove.fromRow][lastMove.fromCol] = lastMove.movedPiece;
      board[lastMove.toRow][lastMove.toCol] = lastMove.capturedPiece;
      whiteTurn = !whiteTurn; // Switch turn back after undo
    }
  }

  List<Move> getPawnMoves(int row, int col) {
    List<Move> pawnMoves = [];
    if (whiteTurn) {
      if (row > 0 && board[row - 1][col] == blank) {
        pawnMoves.add(
          Move(
            fromRow: row,
            fromCol: col,
            toRow: row - 1,
            toCol: col,
            board: board,
          ),
        );
        if (row == 6 && board[row - 2][col] == blank) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row - 2,
              toCol: col,
              board: board,
            ),
          );
        }
      }
      if (row > 0) {
        if (col > 0 &&
            board[row - 1][col - 1] != blank &&
            board[row - 1][col - 1][0] == black) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row - 1,
              toCol: col - 1,
              board: board,
            ),
          );
        }
        if (col < 7 &&
            board[row - 1][col + 1] != blank &&
            board[row - 1][col + 1][0] == black) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row - 1,
              toCol: col + 1,
              board: board,
            ),
          );
        }
      }
    } else {
      if (row < 7 && board[row + 1][col] == blank) {
        pawnMoves.add(
          Move(
            fromRow: row,
            fromCol: col,
            toRow: row + 1,
            toCol: col,
            board: board,
          ),
        );
        if (row == 1 && board[row + 2][col] == blank) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row + 2,
              toCol: col,
              board: board,
            ),
          );
        }
      }
      if (row < 7) {
        if (col > 0 &&
            board[row + 1][col - 1] != blank &&
            board[row + 1][col - 1][0] == white) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row + 1,
              toCol: col - 1,
              board: board,
            ),
          );
        }
        if (col < 7 &&
            board[row + 1][col + 1] != blank &&
            board[row + 1][col + 1][0] == white) {
          pawnMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: row + 1,
              toCol: col + 1,
              board: board,
            ),
          );
        }
      }
    }
    return pawnMoves;
  }

  List<Move> getKnightMoves(int row, int col) {
    // Implement pawn move logic
    return [];
  }

  List<Move> getBishopMoves(int row, int col) {
    // Implement pawn move logic
    return [];
  }

  List<Move> getRookMoves(int row, int col) {
    // Implement pawn move logic
    return [];
  }

  List<Move> getQueenMoves(int row, int col) {
    // Implement pawn move logic
    return [];
  }

  List<Move> getKingMoves(int row, int col) {
    // Implement pawn move logic
    return [];
  }

  bool squareUnderAttack(int row, int col) {
    whiteTurn = !whiteTurn;
    List<Move> opponenetMoves = getAllPossibleMoves();
    whiteTurn = !whiteTurn;
    for (Move move in opponenetMoves) {
      if (move.toRow == row && move.toCol == col) {
        return true;
      }
    }
    return false;
  }

  List<Move> getAllPossibleMoves() {
    List<Move> possibelMoves = [];
    for (int row = 0; row < board.length; row++) {
      for (int col = 0; col < board[row].length; col++) {
        String piece = board[row][col];
        if (piece != blank) {
          String pieceType = piece[1];
          String pieceColor = piece[0];
          if ((pieceColor == white && whiteTurn) ||
              (pieceColor == black && !whiteTurn)) {
            switch (pieceType) {
              case pawn:
                possibelMoves.addAll(getPawnMoves(row, col));
                break;
              case knight:
                possibelMoves.addAll(getKnightMoves(row, col));
                break;
              case bishop:
                possibelMoves.addAll(getBishopMoves(row, col));
                break;
              case rook:
                possibelMoves.addAll(getRookMoves(row, col));
                break;
              case queen:
                possibelMoves.addAll(getQueenMoves(row, col));
                break;
              case king:
                possibelMoves.addAll(getKingMoves(row, col));
                break;
            }
          }
        }
      }
    }
    return possibelMoves;
  }

  List<Move> getValidMoves() {
    List<Move> allMoves = getAllPossibleMoves();
    List<Move> validMoves = [];
    for (Move move in allMoves) {
      makeMove(move);
      whiteTurn = !whiteTurn;
      validMoves.add(move);
      whiteTurn = !whiteTurn;
      undoMove();
    }
    return validMoves;
  }
}
