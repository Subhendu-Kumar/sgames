import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const ChessBoard(),
    );
  }
}

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  List<List<String>> board = [
    ['br', 'bn', 'bb', 'bq', 'bk', 'bb', 'bn', 'br'],
    ['bp', 'bp', 'bp', 'bp', 'bp', 'bp', 'bp', 'bp'],
    ['--', '--', '--', '--', '--', '--', '--', '--'],
    ['--', '--', '--', '--', '--', '--', '--', '--'],
    ['--', '--', '--', '--', '--', '--', '--', '--'],
    ['--', '--', '--', '--', '--', '--', '--', '--'],
    ['wp', 'wp', 'wp', 'wp', 'wp', 'wp', 'wp', 'wp'],
    ['wr', 'wn', 'wb', 'wq', 'wk', 'wb', 'wn', 'wr'],
  ];

  String getUnicode(String code) {
    final map = {
      'wk': '♔',
      'wq': '♕',
      'wr': '♖',
      'wb': '♗',
      'wn': '♘',
      'wp': '♙',
      'bk': '♚',
      'bq': '♛',
      'br': '♜',
      'bb': '♝',
      'bn': '♞',
      'bp': '♟',
    };
    return map[code] ?? '';
  }

  int? selectedRow;
  int? selectedCol;

  void movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    String piece = board[fromRow][fromCol];
    board[fromRow][fromCol] = '--';
    board[toRow][toCol] = piece;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chess Board')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double boardSize = constraints.maxWidth;
            double tileSize = boardSize / 8;
            return Center(
              child: SizedBox(
                width: boardSize,
                height: boardSize,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 64,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    String piece = board[row][col];
                    bool isWhiteTile = (row + col) % 2 == 0;
                    bool isSelected = row == selectedRow && col == selectedCol;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedRow == null && piece != '--') {
                            selectedRow = row;
                            selectedCol = col;
                          } else if (selectedRow != null) {
                            movePiece(selectedRow!, selectedCol!, row, col);
                            selectedRow = null;
                            selectedCol = null;
                          }
                        });
                      },
                      child: Container(
                        width: tileSize,
                        height: tileSize,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.greenAccent
                              : isWhiteTile
                              ? Colors.brown[100]
                              : Colors.brown[700],
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Center(
                          child: Text(
                            piece != '--' ? getUnicode(piece) : '',
                            style: TextStyle(
                              fontSize: tileSize * 0.4,
                              fontWeight: FontWeight.bold,
                              color: piece.startsWith('b')
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
