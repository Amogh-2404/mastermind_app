import 'dart:math';

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
    required List<int> secretCode,
  }) {
    gameHelper = GameHelper();
    // List<int> secretCode = gameHelper.generateRandomCode(numColors, codeLength);
    newGameData = GameData(numColors, populationSize, codeLength, secretCode, numGenerations, 0.1);
  }

  Future<List<List<List<int>>>> geneticAlgorithm() async {
    List<List<int>> population = List.generate(
        newGameData.populationSize, (_) => gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength));
    List<int> temp = gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength);
    List<List<List<int>>> guessList = [[gameHelper.hint(temp, newGameData.secretCode, newGameData.codeLength, newGameData.numColors), temp]];

    for (int generation = 0; generation < newGameData.numGenerations; generation++) {
      if (generation % 15 == 0) {
        population = List.generate(
            newGameData.populationSize, (_) => gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength));
      }

      List<int> fitnessList = [];
      for (var individual in population) {
        int totalDist = guessList.fold(0, (sum, guess) {
          var h = gameHelper.hint(individual, guess.last, newGameData.codeLength, newGameData.numColors);
          var hi = gameHelper.hint(guess.last, newGameData.secretCode, newGameData.codeLength, newGameData.numColors);
          return sum + gameHelper.distance(h, hi);
        });
        fitnessList.add(gameHelper.calculateFitness(totalDist));
      }

      await Future.delayed(Duration.zero);

      List<List<dynamic>> populationWithFitness = List.generate(population.length, (index) => [fitnessList[index], population[index]]);
      populationWithFitness.sort((a, b) => b[0].compareTo(a[0]));

      if (populationWithFitness.first[0] == 0) {
        var newGuess = List<int>.from(populationWithFitness.first[1]);
        var newHint = gameHelper.hint(newGuess, newGameData.secretCode, newGameData.codeLength, newGameData.numColors);
        guessList.add([newHint, newGuess]);
      }

      if (gameHelper.hint(guessList.last.last, newGameData.secretCode, newGameData.codeLength, newGameData.numColors)[0] == newGameData.codeLength) {
        break;
      }

      await Future.delayed(Duration.zero);

      population = populationWithFitness.map((e) => List<int>.from(e[1])).toList();

      // Evolutionary operations: transposition, crossover, and mutation
      final random = Random();
      int half = population.length ~/ 2;
      population = population.sublist(half);

      int transpositionSize = population.length ~/ 5;
      int crossoverSize = (transpositionSize * 2) ~/ 5;
      int mutateSize = population.length - (transpositionSize + crossoverSize);

      Set<List<int>> transpositionPopulation = {};
      while (transpositionPopulation.length < transpositionSize) {
        var randomIndex = random.nextInt(population.length);
        transpositionPopulation.add(population[randomIndex]);
      }

      Set<List<int>> crossoverPopulation = {};
      while (crossoverPopulation.length < crossoverSize) {
        var randomIndex = random.nextInt(population.length);
        crossoverPopulation.add(population[randomIndex]);
      }

      Set<List<int>> mutatePopulation = {};
      while (mutatePopulation.length < mutateSize) {
        var randomIndex = random.nextInt(population.length);
        mutatePopulation.add(population[randomIndex]);
      }

      List<List<int>> transpositionPopulationList = transpositionPopulation.map((e) => gameHelper.transpose(e)).toList();
      List<List<int>> crossoverPopulationList = [];
      int i = 0;
      while (i < crossoverSize) {
        var randomIndex1 = random.nextInt(crossoverPopulation.length);
        var randomIndex2 = random.nextInt(crossoverPopulation.length);
        while (randomIndex2 == randomIndex1) {
          randomIndex2 = random.nextInt(crossoverPopulation.length);
        }
        var crossover = gameHelper.crossover(crossoverPopulation.elementAt(randomIndex1), crossoverPopulation.elementAt(randomIndex2), newGameData.codeLength);
        crossoverPopulationList.add(crossover[0]);
        if (++i < crossoverSize) {
          crossoverPopulationList.add(crossover[1]);
          i++;
        }
      }

      List<List<int>> mutatePopulationList = mutatePopulation.map((e) => gameHelper.circularMutate(e)).toList();
      population = [...transpositionPopulationList, ...crossoverPopulationList, ...mutatePopulationList];

    }

    await Future.delayed(Duration(seconds: 1), () => print('Finished'));
    return guessList;
  }
}
