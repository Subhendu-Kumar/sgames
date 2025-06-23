import 'package:sgames/tic_tac_toe/data/variables_and_constants.dart';

// Game state variables
class GameEngine {
  late List<String> board;
  late String currentPlayer;
  late String winner;

  GameEngine() {
    board = List.filled(9, empty);
    currentPlayer = cross;
    winner = empty;
  }

  bool makeMove(int position) {
    if (position < 0 ||
        position >= board.length ||
        board[position] != empty ||
        winner.isNotEmpty) {
      return false; // Invalid move
    }
    board[position] = currentPlayer;
    if (checkWinner()) {
      return true; // Move made and game won
    }
    currentPlayer = currentPlayer == cross ? roll : cross; // Switch player
    return true; // Move made but no winner yet
  }

  bool checkWinner() {
    for (List<int> combination in winningCombinations) {
      if (board[combination[0]] != empty &&
          board[combination[0]] == board[combination[1]] &&
          board[combination[1]] == board[combination[2]]) {
        winner = board[combination[0]];
        return true; // Winner found
      }
    }
    return false; // No winner yet
  }
}
