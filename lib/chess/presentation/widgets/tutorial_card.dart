// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TutorialCard extends StatelessWidget {
  String title;
  String description;
  TutorialCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[50],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
