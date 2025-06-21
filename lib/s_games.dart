import 'package:flutter/material.dart';
import 'package:sgames/chess/presentation/view/chess_home_page.dart';

class SGames extends StatelessWidget {
  const SGames({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S Games',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const ChessHomePage(),
    );
  }
}
