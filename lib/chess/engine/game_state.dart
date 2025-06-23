import 'package:sgames/chess/engine/move.dart';
import 'package:sgames/chess/data/variables_and_constants.dart';

class GameState {
  late List<List<String>> board;
  late List<Move> moveLog;
  late bool whiteTurn;
  late List<int> whiteKingPosition;
  late List<int> blackKingPosition;
  late bool checkMate;
  late bool staleMate;

  GameState() {
    board = List<List<String>>.from(
      initialBoard.map((row) => List<String>.from(row)),
    ); // Initialize the board with the initial setup
    moveLog = []; // Initialize the move log
    whiteTurn = true; // White starts the game
    whiteKingPosition = [7, 4]; // Initial position of the white king
    blackKingPosition = [0, 4]; // Initial position of the black king
    checkMate = false; // Initially not in checkmate
    staleMate = false; // Initially not in stalemate
  }

  // Get all possible moves for a pawn
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

  // Get all possible moves for a knight
  List<Move> getKnightMoves(int row, int col) {
    List<Move> knightMoves = [];
    String allyColor = whiteTurn ? white : black;
    for (List<int> offset in knightMoveOffsets) {
      int newRow = row + offset[0];
      int newCol = col + offset[1];
      if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
        String targetSquare = board[newRow][newCol];
        if (targetSquare == blank || targetSquare[0] != allyColor) {
          knightMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              board: board,
            ),
          );
        }
      }
    }
    return knightMoves;
  }

  // Get all possible moves for a bishop
  List<Move> getBishopMoves(int row, int col) {
    List<Move> bishopMoves = [];
    String enemyColor = whiteTurn ? black : white;
    for (List<int> offset in bishopMoveOffsets) {
      for (int i = 1; i < 8; i++) {
        int newRow = row + offset[0] * i;
        int newCol = col + offset[1] * i;
        if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
          String targetSquare = board[newRow][newCol];
          if (targetSquare == blank) {
            bishopMoves.add(
              Move(
                fromRow: row,
                fromCol: col,
                toRow: newRow,
                toCol: newCol,
                board: board,
              ),
            );
          } else if (targetSquare[0] == enemyColor) {
            bishopMoves.add(
              Move(
                fromRow: row,
                fromCol: col,
                toRow: newRow,
                toCol: newCol,
                board: board,
              ),
            );
            break; // Can't continue after capturing
          } else {
            break; // Blocked by own piece
          }
        } else {
          break; // Out of bounds
        }
      }
    }
    return bishopMoves;
  }

  // Get all possible moves for a rook
  List<Move> getRookMoves(int row, int col) {
    List<Move> rookMoves = [];
    String enemyColor = whiteTurn ? black : white;
    for (List<int> offset in rookMoveOffsets) {
      for (int i = 0; i < 8; i++) {
        int newRow = row + offset[0] * i;
        int newCol = col + offset[1] * i;
        if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
          String targetSquare = board[newRow][newCol];
          if (targetSquare == blank) {
            rookMoves.add(
              Move(
                fromRow: row,
                fromCol: col,
                toRow: newRow,
                toCol: newCol,
                board: board,
              ),
            );
          } else if (targetSquare[0] == enemyColor) {
            rookMoves.add(
              Move(
                fromRow: row,
                fromCol: col,
                toRow: newRow,
                toCol: newCol,
                board: board,
              ),
            );
            break; // Can't continue after capturing
          } else {
            break; // Blocked by own piece
          }
        } else {
          break; // Out of bounds
        }
      }
    }
    return rookMoves;
  }

  // Get all possible moves for a queen
  List<Move> getQueenMoves(int row, int col) {
    List<Move> queenMoves = [];
    queenMoves.addAll(getBishopMoves(row, col));
    queenMoves.addAll(getRookMoves(row, col));
    return queenMoves;
  }

  // Get all possible moves for a king
  List<Move> getKingMoves(int row, int col) {
    List<Move> kingMoves = [];
    String allyColor = whiteTurn ? white : black;
    for (List<int> offset in kingMoveOffsets) {
      int newRow = row + offset[0];
      int newCol = col + offset[1];
      if (0 <= newRow && newRow < 8 && 0 <= newCol && newCol < 8) {
        String targetSquare = board[newRow][newCol];
        if (targetSquare == blank || targetSquare[0] != allyColor) {
          kingMoves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              board: board,
            ),
          );
        }
      }
    }
    return kingMoves;
  }

  // Check if the current player is in check
  bool isCheck() {
    if (whiteTurn) {
      return squareUnderAttack(whiteKingPosition[0], whiteKingPosition[1]);
    } else {
      return squareUnderAttack(blackKingPosition[0], blackKingPosition[1]);
    }
  }

  // Check if a square is under attack by the opponent
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

  // Get all possible moves for the current player
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

  // Get all valid moves for the current player
  List<Move> getValidMoves() {
    List<Move> allMoves = getAllPossibleMoves();
    List<Move> validMoves = [];
    for (Move move in allMoves) {
      makeMove(move);
      whiteTurn = !whiteTurn;
      if (!isCheck()) {
        validMoves.add(move);
      }
      whiteTurn = !whiteTurn;
      undoMove();
    }
    if (validMoves.isEmpty) {
      if (isCheck()) {
        checkMate = true;
      } else {
        staleMate = true;
      }
    } else {
      checkMate = false;
      staleMate = false;
    }
    return validMoves;
  }

  // Make a move on the board
  void makeMove(Move move) {
    board[move.fromRow][move.fromCol] = blank;
    board[move.toRow][move.toCol] = move.movedPiece;
    moveLog.add(move);
    whiteTurn = !whiteTurn; // Switch turn after a move
  }

  // Undo the last move
  void undoMove() {
    if (moveLog.isNotEmpty) {
      Move lastMove = moveLog.removeLast();
      board[lastMove.fromRow][lastMove.fromCol] = lastMove.movedPiece;
      board[lastMove.toRow][lastMove.toCol] = lastMove.capturedPiece;
      whiteTurn = !whiteTurn; // Switch turn back after undo
    }
  }
}
