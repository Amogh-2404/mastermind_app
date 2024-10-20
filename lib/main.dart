// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/cupertino.dart';
// import "package:flutter/material.dart";
// import 'package:flutter/widgets.dart';
//
// import 'menu_drawer.dart';
//
// void main() => runApp(
//     MastermindApp());
//
// class MastermindApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mastermind',
//       home: SplashScreen(),
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       Duration(seconds: 3),
//           () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SettingsScreen())),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blue,
//       child: const Center(
//         child: Text(
//           'Mastermind',
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
//
// class SettingsScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   int numColors = 6;
//   int codeLength = 4;
//   int populationSize = 100;
//   int numGenerations = 500;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MenuDrawer(),
//       key: _scaffoldKey,
//       appBar: AppBar(title: const Text("Game Settings",style: TextStyle(color: Colors.blue),),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () => Scaffold.of(context).openDrawer(),
//           tooltip: 'Menu',
//         ),
//       ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child:Form(
//
//         key: _formKey,
//         child: ListView(
//           children: [
//
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child:TextFormField(
//               decoration: InputDecoration(labelText: 'Number of Colors',
//                   floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   enabledBorder: OutlineInputBorder( // Normal border style
//                     borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//                     borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
//                   ),
//                   focusedBorder: OutlineInputBorder( // Border style when the field is focused
//                     borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
//               ),
//               initialValue: numColors.toString(),
//               keyboardType: TextInputType.number,
//               onSaved: (value) => numColors = int.parse(value ?? '6'),
//             ),),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Code Length',floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   enabledBorder: OutlineInputBorder( // Normal border style
//                     borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//                     borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
//                   ),
//                   focusedBorder: OutlineInputBorder( // Border style when the field is focused
//                     borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
//                 initialValue: codeLength.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => codeLength = int.parse(value ?? '4'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Population Size',floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   enabledBorder: OutlineInputBorder( // Normal border style
//                     borderSide:const BorderSide(color: Colors.grey, width: 1.0),
//                     borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
//                   ),
//                   focusedBorder: OutlineInputBorder( // Border style when the field is focused
//                     borderSide:const BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
//                 initialValue: populationSize.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => populationSize = int.parse(value ?? '100'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Number of Generations',floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   enabledBorder: OutlineInputBorder( // Normal border style
//                     borderSide: const BorderSide(color: Colors.grey, width: 1.0),
//                     borderRadius: BorderRadius.circular(100.0), // Pill-shaped border
//                   ),
//                   focusedBorder: OutlineInputBorder( // Border style when the field is focused
//                     borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0), // Pill-shaped border
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),),
//                 initialValue: numGenerations.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => numGenerations = int.parse(value ?? '500'),
//               ),
//             ),
//             Align(
//                 alignment: Alignment.center,
//
//                 child:Padding(
//                     padding:const EdgeInsets.all(10) ,
//                     child:ElevatedButton(
//               style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),padding: MaterialStateProperty.all(EdgeInsets.all(10)),
//               maximumSize: MaterialStateProperty.all(const Size(100, 100))),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MastermindGame(
//                         numColors: numColors,
//                         codeLength: codeLength,
//                         populationSize: populationSize,
//                         numGenerations: numGenerations,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child:
//                   const Align(
//                     alignment: Alignment.center,
//                     child:Icon(Icons.play_arrow,color: Colors.white,size: 35,),)
//                   // Text('Start Game',style: TextStyle(color: Colors.white,fontFamily: 'Helvatica',fontSize: 16),),]
//
//               )
//     ),
//     ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }
// }
//
// class MastermindGame extends StatefulWidget {
//   final int numColors;
//   final int codeLength;
//   final int populationSize;
//   final int numGenerations;
//
//   MastermindGame({
//     required this.numColors,
//     required this.codeLength,
//     required this.populationSize,
//     required this.numGenerations,
//   });
//
//   @override
//   _MastermindGameState createState() => _MastermindGameState();
// }
//
//
// class _MastermindGameState extends State<MastermindGame> {
//
//   List<List<int>> guesses = [];
//   List<int> solution = [];
//   bool gameWon = false;
//   final Random random = Random();
//
//   @override
//   void initState() {
//     super.initState();
//     _generateSolution();
//     _simulateGuesses();
//   }
//
//   void _generateSolution() {
//     solution = List.generate(widget.codeLength, (_) => random.nextInt(widget.numColors) + 1);
//     gameWon = false;
//   }
//
//   Color _getColor(int number) {
//     List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple, Colors.orange];
//     return colors[number - 1];
//   }
//
//   void _simulateGuesses() async {
//     List<List<int>> simulatedGuesses = [
//       [1, 2, 3, 4],  // Example guesses, should be replaced with actual game logic
//       [2, 3, 4, 1],
//       [3, 4, 1, 2],
//       solution,
//     ];
//
//     for (var guess in simulatedGuesses) {
//       await Future.delayed(Duration(seconds: 1));
//       setState(() {
//         guesses.add(guess);
//       });
//       if (guess.join() == solution.join()) {
//         setState(() {
//           gameWon = true;
//         });
//         break;
//       }
//     }
//   }
//
//   void _resetGame() {
//     setState(() {
//       guesses.clear();
//       _generateSolution();
//       gameWon = false; // Ensure gameWon is set to false when resetting
//     });
//     // _simulateGuesses();
//     Navigator.pop(context);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => SettingsScreen()),
//     );
//   }
//
//
//
//   // Animated banner
//   bool _showBanner = false;
//
//   void _showCodeCrackedBanner() {
//     setState(() {
//       _showBanner = true;
//     });
//
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         _showBanner = false;
//       });
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mastermind Game',style: TextStyle(color: Colors.blue),
//       ),),
//       body:Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: solution.map((number) => _buildColorCircle(_getColor(number), true)).toList(),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: guesses.length,
//               itemBuilder: (context, index) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: guesses[index].map((number) => _buildColorCircle(_getColor(number))).toList(),
//                 );
//               },
//             ),
//           ),
//           if (gameWon)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 onPressed: _resetGame,
//                 child: const Text('Reset Game', style: TextStyle(fontSize: 20)),
//               ),
//             ),
//         ],
//       ),
//
//     );
//   }
//
//   Widget _buildColorCircle(Color color, [bool isSolution = false]) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: isSolution ? Colors.transparent : color,
//         border: isSolution ? Border.all(color: color, width: 3.0) : null,
//         shape: BoxShape.circle,
//       ),
//       width: 50,
//       height: 50,
//     );
//   }
// }
//

import 'dart:async';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'start.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'menu_drawer.dart';

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
      () => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SettingsScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Mastermind',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }
}

enum ColorChoice {
  red,
  green,
  blue,
  yellow,
  purple,
  orange,
  cyan,
  pink,
  teal,
  indigo
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

//Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple, Colors.orange, Colors.cyan, Colors.pink, Colors.teal, Colors.indigo

Map<ColorChoice, Color> globalColorMap = {
  ColorChoice.red: Colors.red,
  ColorChoice.green: Colors.green,
  ColorChoice.blue: Colors.blue,
  ColorChoice.yellow: Colors.yellow,
  ColorChoice.purple: Colors.purple,
  ColorChoice.orange: Colors.orange,
  ColorChoice.cyan: Colors.cyan,
  ColorChoice.pink: Colors.pink,
  ColorChoice.teal: Colors.teal,
  ColorChoice.indigo: Colors.indigo,
};

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  int numColors = 6;
  int codeLength = 4;
  int populationSize = 10;
  int numGenerations = 5000;
  List<ColorChoice?> selectedColors = [];
  ColorChoice? selectedColor;
  late Map<ColorChoice, Color> colorMapReduced;

  @override
  void initState() {
    super.initState();
    selectedColors = List<ColorChoice?>.filled(codeLength, null);
    colorMapReduced = Map.fromEntries(globalColorMap.entries.take(6));
  }

  Map<ColorChoice, Color> colorMap = {
    ColorChoice.red: Colors.red,
    ColorChoice.green: Colors.green,
    ColorChoice.blue: Colors.blue,
    ColorChoice.yellow: Colors.yellow,
    ColorChoice.purple: Colors.purple,
    ColorChoice.orange: Colors.orange,
    ColorChoice.cyan: Colors.cyan,
    ColorChoice.pink: Colors.pink,
    ColorChoice.teal: Colors.teal,
    ColorChoice.indigo: Colors.indigo,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Game Settings",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize:
                      MediaQuery.of(context).size.width > 1000 ? 20 : 15))),
      body: Padding(
        padding: MediaQuery.of(context).size.width < 800
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: MediaQuery.of(context).size.width < 800
                    ? const EdgeInsets.symmetric(vertical: 10.0)
                    : const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 600.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Number of Colors',
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey.shade600,
                    fillColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      // Change the color and width as needed
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    // Define the border style when the field is not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      // Normal border style
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    // Add padding to the input field

                    floatingLabelStyle: TextStyle(
                      color: Colors
                          .blue, // Color of the label when the field is focused
                    ),
                  ),
                  initialValue: numColors.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    numColors = int.parse(value ?? '6');
                    setState(() {
                      colorMapReduced =
                          Map.fromEntries(colorMap.entries.take(numColors));
                    });
                  },
                  onChanged: (value) {
                    numColors = int.parse(value ?? '6');
                    setState(() {
                      colorMapReduced =
                          Map.fromEntries(colorMap.entries.take(numColors));
                    });
                  },
                ),
              ),
              Container(
                margin: MediaQuery.of(context).size.width < 800
                    ? const EdgeInsets.symmetric(vertical: 10.0)
                    : const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 600.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Code Length',
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey.shade600,
                    fillColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      // Change the color and width as needed
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    // Define the border style when the field is not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      // Normal border style
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    // Add padding to the input field
                    floatingLabelStyle: TextStyle(
                      color: Colors
                          .blue, // Color of the label when the field is focused
                    ),
                  ),
                  initialValue: codeLength.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int newCodeLength = int.tryParse(value) ?? codeLength;
                    if (newCodeLength != codeLength) {
                      setState(() {
                        codeLength = newCodeLength;
                        selectedColors =
                            List<ColorChoice?>.filled(codeLength, null);
                      });
                    }
                  },
                  onSaved: (value) {
                    int newCodeLength = int.parse(value ?? '4');
                    setState(() {
                      codeLength = newCodeLength;
                    });
                  },
                ),
              ),
              Container(
                margin: MediaQuery.of(context).size.width < 800
                    ? const EdgeInsets.symmetric(vertical: 10.0)
                    : const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 600.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Population Size',
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey.shade600,
                    fillColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      // Change the color and width as needed
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    // Define the border style when the field is not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      // Normal border style
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    // Add padding to the input field
                    floatingLabelStyle: TextStyle(
                      color: Colors
                          .blue, // Color of the label when the field is focused
                    ),
                  ),
                  initialValue: populationSize.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      populationSize = int.parse(value ?? '10');
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      populationSize = int.parse(value ?? '10');
                    });
                  },
                ),
              ),
              Container(
                margin: MediaQuery.of(context).size.width < 800
                    ? const EdgeInsets.symmetric(vertical: 10.0)
                    : const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 600.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Number of Generations',
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey.shade600,
                    fillColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      // Change the color and width as needed
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    // Define the border style when the field is not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      // Normal border style
                      borderRadius:
                          BorderRadius.circular(30.0), // Pill-shaped border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    // Add padding to the input field
                    floatingLabelStyle: TextStyle(
                      color: Colors
                          .blue, // Color of the label when the field is focused
                    ),
                  ),
                  initialValue: numGenerations.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      numGenerations = int.parse(value ?? '5000'),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: colorMapReduced.keys.map((color) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedColor = color;
                              }),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorMap[color],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: selectedColors.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedColor != null) {
                          // print("HELL YEAH!!!!");
                          print("The secret color is ${selectedColor}");
                          selectedColors[entry.key] = selectedColor;
                        }
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: entry.value == null
                            ? Colors.grey
                            : colorMap[entry.value],
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.all(4),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.all(20), // Background color of the button
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // print(selectedColors);
                        if (selectedColors.any((color) => color == null)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Please fill all the slots with colors."),
                            ),
                          );
                          return;
                        }
                        List<int> secretCode = selectedColors
                            .map((color) =>
                                colorMap.keys.toList().indexOf(color!))
                            .toList();
                        // print(secretCode);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MastermindGame(
                              numColors: numColors,
                              codeLength: codeLength,
                              populationSize: populationSize,
                              numGenerations: numGenerations,
                              secretCode: secretCode,
                            ),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
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

class MastermindGame extends StatefulWidget {
  final int numColors;
  final int codeLength;
  final int populationSize;
  final int numGenerations;
  final List<int> secretCode;

  const MastermindGame({
    Key? key,
    required this.numColors,
    required this.codeLength,
    required this.populationSize,
    required this.numGenerations,
    required this.secretCode,
  }) : super(key: key);

  @override
  _MastermindGameState createState() => _MastermindGameState();
}

class _MastermindGameState extends State<MastermindGame> {
  late Future<List<List<List<int>>>> simulatedGuesses;
  late List<int> solution; // To store the secret code
  int itemsToShow = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    StartDart startDart = StartDart(
      numColors: widget.numColors,
      codeLength: widget.codeLength,
      populationSize: widget.populationSize,
      numGenerations: widget.numGenerations,
      secretCode: widget.secretCode,
    );
    simulatedGuesses = startDart.geneticAlgorithm().whenComplete(() {
      setState(() {
        isLoading = false;
        solution = startDart.newGameData.secretCode;
        // print(solution);
      });
    });

    // Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   if (!isLoading) {
    //     setState(() {
    //       if (itemsToShow < solution.length) {
    //         itemsToShow++;
    //       } else {
    //         timer.cancel(); // Stop the timer when all items are displayed.
    //       }
    //     });
    //   }
    // });
  }

  Color _getColor(int number) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.cyan,
      Colors.pink,
      Colors.teal,
      Colors.indigo
    ];
    return colors[(number) % colors.length];
  }

  Widget _buildColorCircle(Color color, {bool isSecret = false}) {
    return Container(
      margin: MediaQuery.of(context).size.width > 1000
          ? const EdgeInsets.all(6)
          : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSecret ? Colors.transparent : color,
        border: isSecret ? Border.all(color: color, width: 3.0) : null,
        shape: BoxShape.circle,
      ),
      width: MediaQuery.of(context).size.width > 1000 ? 50 : 25,
      height: MediaQuery.of(context).size.width > 1000 ? 50 : 25,
    );
  }

  void resetGame() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Mastermind Game', style: TextStyle(color: Colors.blue)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : Column(
              children: [
                Padding(
                  padding: MediaQuery.of(context).size.width > 1000
                      ? const EdgeInsets.all(6.0)
                      : const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: solution
                              .map((number) => _buildColorCircle(
                                  _getColor(number),
                                  isSecret: true))
                              .toList()),
                      Text("Secret code",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: MediaQuery.of(context).size.width > 1000
                                  ? 20
                                  : 15))
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<List<List<int>>>>(
                    future: simulatedGuesses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        List<List<List<int>>> guesses =
                            snapshot.data!.cast<List<List<int>>>();
                        Timer.periodic(Duration(seconds: 1), (Timer timer) {
                          if (itemsToShow < guesses.length) {
                            setState(() {
                              itemsToShow++;
                            });
                          } else {
                            timer
                                .cancel(); // Stop the timer when all items are displayed.
                          }
                        });
                        return ListView.builder(
                          itemCount: itemsToShow,
                          itemBuilder: (context, index) {
                            if (index < guesses.length) {
                              List<int> currentGuess = guesses[index][1];
                              List<int> hint = guesses[index][0];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: currentGuess
                                        .map((number) => _buildColorCircle(
                                            _getColor(number)))
                                        .toList(),
                                  ),
                                  Text("${hint[0]} black, ${hint[1]} white",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  1000
                                              ? 20
                                              : 15)),
                                  SizedBox(height: 10)
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      // Show a placeholder or loading indicator while waiting for the data
                      return const Text('Awaiting result...');
                    },
                  ),
                ),
                Container(
                  margin: (const EdgeInsets.fromLTRB(5, 3, 5, 200)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                          child: Text("Number of Guesses: ${itemsToShow}",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 1000
                                          ? 20
                                          : 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                        ElevatedButton(
                          onPressed: resetGame,
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 50,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.all(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
