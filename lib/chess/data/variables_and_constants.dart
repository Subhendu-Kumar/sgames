// Colors
const String white = "w";
const String black = "b";

// Blank square
const String blank = "--";

// Piece identifiers
const String pawn = "P";
const String knight = "N";
const String bishop = "B";
const String rook = "R";
const String queen = "Q";
const String king = "K";

// White pieces
const String whitePawn = "$white$pawn";
const String whiteKnight = "$white$knight";
const String whiteBishop = "$white$bishop";
const String whiteRook = "$white$rook";
const String whiteQueen = "$white$queen";
const String whiteKing = "$white$king";

// Black pieces
const String blackPawn = "$black$pawn";
const String blackKnight = "$black$knight";
const String blackBishop = "$black$bishop";
const String blackRook = "$black$rook";
const String blackQueen = "$black$queen";
const String blackKing = "$black$king";

// Initial board setup
// This is the initial setup of a chess board represented as a list of lists.
final List<List<String>> initialBoard = [
  [
    blackRook,
    blackKnight,
    blackBishop,
    blackQueen,
    blackKing,
    blackBishop,
    blackKnight,
    blackRook,
  ],
  [
    blackPawn,
    blackPawn,
    blackPawn,
    blackPawn,
    blackPawn,
    blackPawn,
    blackPawn,
    blackPawn,
  ],
  [blank, blank, blank, blank, blank, blank, blank, blank],
  [blank, blank, blank, blank, blank, blank, blank, blank],
  [blank, blank, blank, blank, blank, blank, blank, blank],
  [blank, blank, blank, blank, blank, blank, blank, blank],
  [
    whitePawn,
    whitePawn,
    whitePawn,
    whitePawn,
    whitePawn,
    whitePawn,
    whitePawn,
    whitePawn,
  ],
  [
    whiteRook,
    whiteKnight,
    whiteBishop,
    whiteQueen,
    whiteKing,
    whiteBishop,
    whiteKnight,
    whiteRook,
  ],
];

// knight move offsets
List<List<int>> knightMoveOffsets = [
  [-2, -1],
  [-2, 1],
  [-1, -2],
  [-1, 2],
  [1, -2],
  [1, 2],
  [2, -1],
  [2, 1],
];

// bishop move offsets
List<List<int>> bishopMoveOffsets = [
  [-1, -1],
  [-1, 1],
  [1, -1],
  [1, 1],
];

// rook move offsets
List<List<int>> rookMoveOffsets = [
  [-1, 0],
  [0, -1],
  [1, 0],
  [0, 1],
];

// king move offsets
List<List<int>> kingMoveOffsets = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1],
];
