import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RockPaperScissorsApp());
}

class RockPaperScissorsApp extends StatelessWidget {
  const RockPaperScissorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FIXED: Removed 'const' from MaterialApp because GameScreen is dynamic
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // 1. Game Data
  final List<String> _choices = ['Rock', 'Paper', 'Scissors'];
  final List<String> _emojis = ['✊', '✋', '✌️'];

  // 2. State Variables
  String _playerChoice = '';
  String _computerChoice = '';
  String _result = 'Choose your weapon!';
  int _playerScore = 0;
  int _computerScore = 0;

  // 3. Game Engine Function
  void _playGame(int playerIndex) {
    final random = Random();
    int computerIndex = random.nextInt(3);

    setState(() {
      _playerChoice = '${_emojis[playerIndex]} ${_choices[playerIndex]}';
      _computerChoice = '${_emojis[computerIndex]} ${_choices[computerIndex]}';

      if (playerIndex == computerIndex) {
        _result = "It's a tie! 👔";
      } else if ((playerIndex == 0 && computerIndex == 2) ||
          (playerIndex == 1 && computerIndex == 0) ||
          (playerIndex == 2 && computerIndex == 1)) {
        _result = "You Win! 🎉";
        _playerScore++; 
      } else {
        _result = "Computer Wins! 😢";
        _computerScore++; 
      }
    });
  }

  // 4. Reset function
  void _resetGame() {
    setState(() {
      _playerScore = 0;
      _computerScore = 0;
      _playerChoice = '';
      _computerChoice = '';
      _result = 'Choose your weapon!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Paper Scissors'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ADDED: Live scoreboard layout at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('You: $_playerScore', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                Text('CPU: $_computerScore', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
            const SizedBox(height: 40), 

            // Display game result text
            Text(
              _result,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40), 
            
            // Conditional rendering: Only show choices if the player has made a move
            if (_playerChoice.isNotEmpty) ...[
              Text('You: $_playerChoice', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text(
                'Computer: $_computerChoice',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
            ],

            // Row of interactive weapon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _playGame(index), 
                    child: Text(
                      _emojis[index],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 40),

            // ADDED: Reset button at the bottom connected to your _resetGame function
            TextButton.icon(
              onPressed: _resetGame,
              icon: const Icon(Icons.refresh, color: Colors.red),
              label: const Text('Reset Scores', style: TextStyle(color: Colors.red, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
