import 'game_data.dart';
import 'game_helper.dart';

class StartDart {
  late GameData newGameData;
  late GameHelper gameHelper;

  StartDart({
    required int numColors,
    required int codeLength,
    required int populationSize,
    required int numGenerations,
  }) {
    gameHelper = GameHelper();
    List<int> secretCode = gameHelper.generateRandomCode(numColors, codeLength);
    newGameData = GameData(numColors, populationSize, codeLength, secretCode, numGenerations, 0.1);
  }

  Future<List<List<int>>> geneticAlgorithm() async {
    List<List<int>> population = List.generate(
        newGameData.populationSize, (_) => gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength));
    List<List<int>> guessList = [gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength)];

    for (int generation = 0; generation < newGameData.numGenerations; generation++) {
      List<int> fitnessList = [];
      for (var individual in population) {
        int totalDist = guessList.fold(0, (sum, guess) {
          var h = gameHelper.hint(individual, guess, newGameData.codeLength, newGameData.numColors);
          var hi = gameHelper.hint(guess, newGameData.secretCode, newGameData.codeLength, newGameData.numColors);
          return sum + gameHelper.distance(h, hi);
        });
        fitnessList.add(gameHelper.calculateFitness(totalDist));
      }

      List<List<dynamic>> populationWithFitness = List.generate(population.length, (index) => [fitnessList[index], population[index]]);
      populationWithFitness.sort((a, b) => b[0].compareTo(a[0]));

      if (populationWithFitness.first[0] == 0) {
        var newGuess = List<int>.from(populationWithFitness.first[1]);
        guessList.add(newGuess);
        if (gameHelper.hint(newGuess, newGameData.secretCode, newGameData.codeLength, newGameData.numColors)[0] == newGameData.codeLength) {
          break;
        }
      }

      population = populationWithFitness.map((e) => List<int>.from(e[1])).toList();
    }

    return guessList;
  }
}

