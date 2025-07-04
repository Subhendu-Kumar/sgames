// This file contains constants and variables used in the Tic Tac Toe game.

const String empty = "";
const String cross = "X";
const String roll = "O";

final List<List<int>> winningCombinations = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];

final List<int> corners = [0, 2, 6, 8];
