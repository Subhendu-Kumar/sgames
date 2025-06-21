import 'package:flutter/material.dart';

class AboutDialogW extends StatelessWidget {
  const AboutDialogW({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AboutDialogW(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Chess Game'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('A beautiful Flutter chess game with:'),
          SizedBox(height: 10),
          Text('• Interactive chess board'),
          Text('• Move tracking and history'),
          Text('• Undo functionality'),
          Text('• Intuitive tap-to-move controls'),
          SizedBox(height: 15),
          Text('Developed with Flutter'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
