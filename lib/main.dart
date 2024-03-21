import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';

import 'menu_drawer.dart';

void main() => runApp(
    MastermindApp());

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
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SettingsScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Mastermind',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  int numColors = 6;
  int codeLength = 4;
  int populationSize = 100;
  int numGenerations = 500;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Game Settings",style: TextStyle(color: Colors.blue),),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Menu',
        ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Form(

        key: _formKey,
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:TextFormField(
              decoration: InputDecoration(labelText: 'Number of Colors',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder( // Normal border style
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              ),
              initialValue: numColors.toString(),
              keyboardType: TextInputType.number,
              onSaved: (value) => numColors = int.parse(value ?? '6'),
            ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Code Length',floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder( // Normal border style
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
                initialValue: codeLength.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => codeLength = int.parse(value ?? '4'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Population Size',floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder( // Normal border style
                    borderSide:const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderSide:const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
                initialValue: populationSize.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => populationSize = int.parse(value ?? '100'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Number of Generations',floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder( // Normal border style
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
                  ),
                  focusedBorder: OutlineInputBorder( // Border style when the field is focused
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
                initialValue: numGenerations.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => numGenerations = int.parse(value ?? '500'),
              ),
            ),
            Align(
                alignment: Alignment.center,

                child:Padding(
                    padding:const EdgeInsets.all(10) ,
                    child:ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              maximumSize: MaterialStateProperty.all(const Size(100, 100))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MastermindGame(
                        numColors: numColors,
                        codeLength: codeLength,
                        populationSize: populationSize,
                        numGenerations: numGenerations,
                      ),
                    ),
                  );
                }
              },
              child:
                  const Align(
                    alignment: Alignment.center,
                    child:Icon(Icons.play_arrow,color: Colors.white,size: 35,),)
                  // Text('Start Game',style: TextStyle(color: Colors.white,fontFamily: 'Helvatica',fontSize: 16),),]

              )
    ),
    ),
          ],
        ),
      ),
    ),
    );
  }
}

class MastermindGame extends StatefulWidget {
  final int numColors;
  final int codeLength;
  final int populationSize;
  final int numGenerations;

  MastermindGame({
    required this.numColors,
    required this.codeLength,
    required this.populationSize,
    required this.numGenerations,
  });

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
    solution = List.generate(widget.codeLength, (_) => random.nextInt(widget.numColors) + 1);
    gameWon = false;
  }

  Color _getColor(int number) {
    List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple, Colors.orange];
    return colors[number - 1];
  }

  void _simulateGuesses() async {
    List<List<int>> simulatedGuesses = [
      [1, 2, 3, 4],  // Example guesses, should be replaced with actual game logic
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
      gameWon = false; // Ensure gameWon is set to false when resetting
    });
    // _simulateGuesses();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }



  // Animated banner
  bool _showBanner = false;

  void _showCodeCrackedBanner() {
    setState(() {
      _showBanner = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showBanner = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastermind Game',style: TextStyle(color: Colors.blue),
      ),),
      body:Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Reset Game', style: TextStyle(fontSize: 20)),
              ),
            ),
        ],
      ),

    );
  }

  Widget _buildColorCircle(Color color, [bool isSolution = false]) {
    return Container(
      margin: const EdgeInsets.all(4),
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

