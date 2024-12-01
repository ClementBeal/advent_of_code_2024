import 'dart:io';

void main() {
  final inputData = File("inputs/1.txt").readAsLinesSync();

  final firstList = <int>[];
  final secondList = <int>[];

  // current location id - counter value
  final firstCounter = <int, int>{};
  final secondCounter = <int, int>{};

  for (final line in inputData) {
    final tokens = line.split("   ").map(int.parse).toList();

    final firstValue = tokens[0];
    final secondValue = tokens[1];

    firstList.add(firstValue);
    secondList.add(secondValue);

    firstCounter.update(
      firstValue,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
    secondCounter.update(
      secondValue,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
  }

  firstList.sort();
  secondList.sort();

  int distance = 0;
  int similarityScore = 0;

  for (int i = 0; i < inputData.length; i++) {
    distance += (firstList[i] - secondList[i]).abs();

    final score = firstList[i] * (secondCounter[firstList[i]] ?? 0);

    similarityScore += score;
  }

  print("Total distance : $distance");
  print("Similarity score : $similarityScore");
}
