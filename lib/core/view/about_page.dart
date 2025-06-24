import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Sgames"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.sports_esports,
                  size: 80,
                  color: Colors.purple[300],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome to Sgames 🎮",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[300],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Sgames is your go-to hub for classic and modern games, all in one place! Whether you want to challenge your brain with Tic Tac Toe or engage in a battle of strategy with Chess, Sgames has something for everyone.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "🎯 Key Features:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("Play popular games like Tic Tac Toe and Chess."),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("Smooth and responsive gameplay experience."),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("Clean, attractive, and user-friendly UI."),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("More exciting games will be added regularly!"),
              ),
              const SizedBox(height: 20),
              const Text(
                "🚀 Upcoming Features:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.orange),
                title: Text("Multiplayer support for select games."),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.orange),
                title: Text("Leaderboard & Achievements."),
              ),
              const ListTile(
                leading: Icon(Icons.star, color: Colors.orange),
                title: Text("AI Opponents with increasing difficulty."),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Thank you for playing with Sgames!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
