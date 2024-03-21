import 'dart:math';
import 'game_data.dart';

class GameHelper {
  Random random = Random();

  List<int> generateRandomCode(int numColors, int codeLength) {
    return List<int>.generate(codeLength, (_) => random.nextInt(numColors) + 1);
  }

  List<int> hint(List<int> code, List<int> secretCode, int codeLength, int numColors) {
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
    return (pegList1[0] - pegList2[0]).abs() + (pegList1[1] - pegList2[1]).abs();
  }

  int calculateFitness(int totalDist) {
    return -totalDist;
  }

  List<List<int>> crossover(List<int> parent1, List<int> parent2, int codeLength) {
    int point = random.nextInt(codeLength - 1) + 1;
    List<int> offspring1 = parent1.sublist(0, point) + parent2.sublist(point);
    List<int> offspring2 = parent2.sublist(0, point) + parent1.sublist(point);
    return [offspring1, offspring2];
  }

  List<int> mutate(List<int> code, double mutationRate, int codeLength, int numColors) {
    if (random.nextDouble() < mutationRate) {
      int mutationPoint = random.nextInt(codeLength);
      code[mutationPoint] = random.nextInt(numColors) + 1;
    }
    return code;
  }
}
