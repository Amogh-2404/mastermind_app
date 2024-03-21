import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:mastermind_app/menu_drawer.dart';

import 'game_data.dart';

void main() => runApp(MastermindApp());

class MastermindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mastermind',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MastermindGame())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,  // Splash screen color
      child: Center(
        child: Text(
          'Mastermind',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class MastermindGame extends StatefulWidget {
  @override
  _MastermindGameState createState() => _MastermindGameState();
}

class _MastermindGameState extends State<MastermindGame> {
  List<List<int>> guesses = [];
  List<int> solution = [];
  bool gameWon = false;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _generateSolution();
    _simulateGuesses();
  }

  void _generateSolution() {
    solution = List.generate(4, (_) => random.nextInt(6) + 1);
    gameWon = false;
  }

  Color _getColor(int number) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];
    return colors[number - 1];
  }

  void _simulateGuesses() async {
    GameData gameData = GameData(6, 100, 4, [1,1,2,1], 10000, 0);
    List<List<int>> simulatedGuesses = [
      [1, 2, 3, 4],
      [2, 3, 4, 1],
      [3, 4, 1, 2],
      solution,
    ];

    for (var guess in simulatedGuesses) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        guesses.add(guess);
      });
      if (guess.join() == solution.join()) {
        setState(() {
          gameWon = true;
        });
        break;
      }
    }
  }

  void _resetGame() {
    setState(() {
      guesses.clear();
      _generateSolution();
      _simulateGuesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Mastermind'),
        iconTheme: IconThemeData(color: Colors.blue),
      actions: [
        Tooltip(message:'More',child:IconButton(
          // on hover should provide hint to the user that this button is for search
          padding: const EdgeInsets.only(left:15.0,right: 15.0),
          hoverColor: Theme.of(context).hoverColor,
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),

        ))
      ],),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: solution.map((number) => _buildColorCircle(_getColor(number), true)).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: guesses.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: guesses[index].map((number) => _buildColorCircle(_getColor(number))).toList(),
                );
              },
            ),
          ),
          if (gameWon)
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reset Game',style:TextStyle(fontSize: 20,fontFamily:'Helavtica',color:Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              )
            ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(Color color, [bool isSolution = false]) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSolution ? Colors.transparent : color,
        border: isSolution ? Border.all(color: color, width: 3.0) : null,
        shape: BoxShape.circle,
      ),
      width: 50,
      height: 50,
    );
  }
}

