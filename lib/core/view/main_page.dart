// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sgames/core/view/home_screen.dart';
import 'package:sgames/chess/presentation/view/chess_home_page.dart';
import 'package:sgames/tic_tac_toe/presentation/view/tic_tac_toe_home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _changeTab(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onGameSelected: _changeTab),
      ChessHomePage(),
      TicTacToeHomePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Chess',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Tic Tac Toe',
          ),
        ],
      ),
    );
  }
}
