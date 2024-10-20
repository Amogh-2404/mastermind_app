import 'dart:math';
import 'game_data.dart';

class GameHelper {
  Random random = Random();

  List<int> generateRandomCode(int numColors, int codeLength) {
    return List<int>.generate(codeLength, (_) => random.nextInt(numColors) + 1);
  }

  List<int> hint(
      List<int> code, List<int> secretCode, int codeLength, int numColors) {
    int blackPegs = 0;
    int whitePegs = 0;
    for (int i = 0; i < codeLength; i++) {
      if (code[i] == secretCode[i]) {
        blackPegs++;
      }
    }
    for (int i = 1; i <= numColors; i++) {
      int countInCode = code.where((element) => element == i).length;
      int countInSecret = secretCode.where((element) => element == i).length;
      whitePegs += min(countInCode, countInSecret);
    }
    whitePegs -= blackPegs;
    return [blackPegs, whitePegs];
  }

  int distance(List<int> pegList1, List<int> pegList2) {
    return (pegList1[0] - pegList2[0]).abs() +
        (pegList1[1] - pegList2[1]).abs();
  }

  int calculateFitness(int totalDist) {
    return -totalDist;
  }

  List<int> mutate(
      List<int> code, double mutationRate, int codeLength, int numColors) {
    if (random.nextDouble() < mutationRate) {
      int mutationPoint = random.nextInt(codeLength);
      code[mutationPoint] = random.nextInt(numColors) + 1;
    }
    return code;
  }

  List<int> transpose(List<int> code) {
    Random random = Random();
    List<int> newCode = List.from(code);
    int tcIndex = random.nextInt(newCode.length);
    int transposedColor = newCode.removeAt(tcIndex);
    int insertionPoint = random
        .nextInt(newCode.length + 1); // +1 because we can insert at the end
    newCode.insert(insertionPoint, transposedColor);
    return newCode;
  }

  List<T> circularMutate<T>(List<T> code) {
    if (code.isEmpty) return code;
    List<T> newCode = [];
    newCode.add(code.last);
    newCode.addAll(code.sublist(0, code.length - 1));
    return newCode;
  }

  List<List<T>> selectParents<T>(List<List<T>> populationWithFitness) {
    final Random random = Random();
    List<List<T>> parents = [];
    for (int i = 0; i < populationWithFitness.length ~/ 2; i++) {
      // Randomly select a parent based on weighted choices
      final int index = random.nextInt(populationWithFitness.length);
      parents.add(populationWithFitness[index].first as List<T>);
    }
    return parents;
  }

  List<List<T>> crossover<T>(List<T> parent1, List<T> parent2, int codeLength) {
    final Random random = Random();
    int point = random.nextInt(codeLength - 1) + 1;
    List<T> offspring1 = parent1.sublist(0, point) + parent2.sublist(point);
    List<T> offspring2 = parent2.sublist(0, point) + parent1.sublist(point);
    return [offspring1, offspring2];
  }
}
