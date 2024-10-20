class GameData {
  int numColors;
  int populationSize;
  int codeLength;
  List<int> secretCode;
  int numGenerations;
  double mutationRate;

  GameData(this.numColors, this.populationSize, this.codeLength,
      this.secretCode, this.numGenerations, this.mutationRate);
}
