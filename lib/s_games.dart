import 'package:flutter/material.dart';
import 'package:sgames/core/view/main_page.dart';

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
      home: const MainPage(),
    );
  }
}
