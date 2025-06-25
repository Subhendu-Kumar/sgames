// This file provides a simple AI for Tic Tac Toe that plays against a human player.

import 'package:sgames/tic_tac_toe/engine/game_engine.dart';
import 'package:sgames/tic_tac_toe/data/variables_and_constants.dart';

class TicTacToeAi {
  GameEngine gameEngine;

  TicTacToeAi({required this.gameEngine});

  // Simple AI logic for computer moves
  int getComputerMoveIndex() {
    // Strategy 1: Try to win
    int winMove = _findWinningMove(gameEngine.currentPlayer);
    if (winMove != -1) return winMove;

    // Strategy 2: Block player from winning
    String opponentPlayer = gameEngine.currentPlayer == cross ? roll : cross;
    int blockMove = _findWinningMove(opponentPlayer);
    if (blockMove != -1) return blockMove;

    // Strategy 3: Take center if available
    if (gameEngine.board[4].isEmpty) return 4;

    // Strategy 4: Take corners
    for (int corner in corners) {
      if (gameEngine.board[corner].isEmpty) return corner;
    }

    // Strategy 5: Take any available spot
    for (int i = 0; i < gameEngine.board.length; i++) {
      if (gameEngine.board[i].isEmpty) return i;
    }

    return 0; // Fallback (shouldn't reach here)
  }

  // Find winning move for a player
  int _findWinningMove(String player) {
    for (List<int> combination in winningCombinations) {
      List<String> line = combination.map((i) => gameEngine.board[i]).toList();

      // Check if this line has 2 of player's marks and 1 empty
      if (line.where((mark) => mark == player).length == 2 &&
          line.where((mark) => mark.isEmpty).length == 1) {
        // Return the empty position
        for (int i = 0; i < 3; i++) {
          if (line[i].isEmpty) {
            return combination[i];
          }
        }
      }
    }

    return -1; // No winning move found
  }
}
