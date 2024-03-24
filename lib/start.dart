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
  }) {
    gameHelper = GameHelper();
    List<int> secretCode = gameHelper.generateRandomCode(numColors, codeLength);
    newGameData = GameData(numColors, populationSize, codeLength, secretCode, numGenerations, 0.1);
  }

  Future<List<List<int>>> geneticAlgorithm() async {
    List<List<int>> population = List.generate(
        newGameData.populationSize, (_) => gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength));
    List<List<int>> guessList = [gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength)];
    var count = 0;
    for (int generation = 0; generation < newGameData.numGenerations; generation++) {
      if(count == 15){
        population = List.generate(
            newGameData.populationSize, (_) => gameHelper.generateRandomCode(newGameData.numColors, newGameData.codeLength));
        count = 0;
      }

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
        count = 0;
        var newGuess = List<int>.from(populationWithFitness.first[1]);
        guessList.add(newGuess);
      }else{
        count++;
      }
      if (gameHelper.hint(guessList.last, newGameData.secretCode, newGameData.codeLength, newGameData.numColors)[0] == newGameData.codeLength) {
        break;
      }

      population = populationWithFitness.map((e) => List<int>.from(e[1])).toList();

      var half = population.length ~/ 2;

      population = population.sublist(half, population.length);

      var transposition_size = population.length ~/ 5;

      var crossover_size = (transposition_size*2) ~/ 5;

      var mutate_size = population.length - (transposition_size + crossover_size);

      final random = Random();

      // tranposition population
      Set<List<int>> transposition_population = {};
      while(transposition_population.length < transposition_size){
          var randomIndex = random.nextInt(population.length);
          transposition_population.add(population[randomIndex]);
      }

      // crossover population
      Set<List<int>> crossover_population = {};
      while(crossover_population.length < crossover_size){
          var randomIndex = random.nextInt(population.length);
          crossover_population.add(population[randomIndex]);
      }

      // mutate population
      Set<List<int>> mutate_population = {};
      while(mutate_population.length < mutate_size){
          var randomIndex = random.nextInt(population.length);
          mutate_population.add(population[randomIndex]);
      }

      List<List<int>> transposition_population_list = transposition_population.map((e) => gameHelper.transpose(e)).toList();
      population = [...population, ...transposition_population].toList();

      List<List<int>> mutate_population_list = mutate_population.map((e) => gameHelper.circularMutate(e)).toList();
      population = [...population, ...mutate_population].toList();

      List<List<int>> crossover_population_list = [];
      var i = 0;
      while(i<crossover_size) {
        var randomIndex = random.nextInt(crossover_population.length);
        var randomIndex2 = random.nextInt(crossover_population.length);
        while(randomIndex2==randomIndex){
          randomIndex2 = random.nextInt(crossover_population.length);}
        var crossover = gameHelper.crossover(crossover_population.elementAt(randomIndex), crossover_population.elementAt(randomIndex2), newGameData.codeLength);
        crossover_population_list.add(crossover[0]);
        i+=1;
        if(i<crossover_size){
        crossover_population_list.add(crossover[1]);}
        i+=1;
      }
      population = [...population, ...crossover_population_list].toList();

    }

    await Future.delayed(Duration(seconds: 5), () => print('Finished'));
    print(guessList);
    return guessList;
  }
}

