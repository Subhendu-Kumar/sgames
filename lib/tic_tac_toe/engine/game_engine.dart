// This file provides the game engine for Tic Tac Toe, managing the game state, player turns, and checking for winners.
// It also includes the game mode and player management.

import 'package:sgames/tic_tac_toe/engine/game_mode.dart';
import 'package:sgames/tic_tac_toe/data/variables_and_constants.dart';

class GameEngine {
  List<String> board;
  String currentPlayer;
  String winner;
  String gameMode;
  String humanPlayer;

  GameEngine({
    required this.board,
    required this.currentPlayer,
    required this.winner,
    required this.gameMode,
    required this.humanPlayer,
  });

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

  void setGameMode(String mode) {
    gameMode = mode;
    if (mode == GameMode.playWithComputer) {
      humanPlayer = cross;
      // Computer will be 'O'
    }
  }
}
