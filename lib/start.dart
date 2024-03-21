import 'dart:io';
import 'dart:math';
import 'game_data.dart';
import 'game_helper.dart';

List<List<int>> selectParents(List<List<int>> population, List<int> fitnesses) {
  Random random = Random();
  List<double> weights = fitnesses.map((f) => 1 / (f + 1)).toList();
  double sumWeights = weights.reduce((a, b) => a + b);
  List<double> normalizedWeights = weights.map((w) => w / sumWeights).toList();

  List<List<int>> parents = [];
  for (int i = 0; i < 2; i++) {
    double rand = random.nextDouble();
    double cumulative = 0;
    for (int j = 0; j < population.length; j++) {
      cumulative += normalizedWeights[j];
      if (rand <= cumulative) {
        parents.add(population[j]);
        break;
      }
    }
  }

  return parents;
}

void geneticAlgorithm(GameData gameData, GameHelper gameHelper) {
  List<List<int>> population = List.generate(
      gameData.populationSize,
          (_) => gameHelper.generateRandomCode(gameData.numColors, gameData.codeLength));

  for (int generation = 0; generation < gameData.numGenerations; generation++) {
    List<int> fitnesses = population.map((individual) {
      List<int> hint = gameHelper.hint(individual, gameData.secretCode, gameData.codeLength, gameData.numColors);
      return gameHelper.distance(hint, [gameData.codeLength, 0]);
    }).toList();

    List<List<int>> newPopulation = [];
    while (newPopulation.length < gameData.populationSize) {
      List<List<int>> parents = selectParents(population, fitnesses);
      List<List<int>> offspring = gameHelper.crossover(parents[0], parents[1], gameData.codeLength);
      newPopulation.addAll(offspring.map((o) => gameHelper.mutate(o, gameData.mutationRate, gameData.codeLength, gameData.numColors)));
    }

    population = newPopulation;

    if (fitnesses.any((f) => f == 0)) {
      print("Solution found in generation $generation");
      return;
    }
  }

  print("Solution not found within the generation limit.");
}

void main() {
  print("Enter number of colours:");
  int numColors = int.parse(stdin.readLineSync()!);
  print("Enter number of columns:");
  int codeLength = int.parse(stdin.readLineSync()!);
  print("Enter size of population:");
  int populationSize = int.parse(stdin.readLineSync()!);
  print("Enter number of generations:");
  int numGenerations = int.parse(stdin.readLineSync()!);

  GameHelper gameHelper = GameHelper();
  List<int> secretCode = gameHelper.generateRandomCode(numColors, codeLength);
  GameData gameData = GameData(numColors, populationSize, codeLength, secretCode, numGenerations, 0);

  print("Secret Code: $secretCode");
  geneticAlgorithm(gameData, gameHelper);
}
