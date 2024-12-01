import 'dart:io';

void main() {
  final inputData = File("inputs/1.txt").readAsLinesSync();

  final firstList = <int>[];
  final secondList = <int>[];

  for (final line in inputData) {
    final tokens = line.split("   ").map(int.parse).toList();

    firstList.add(tokens[0]);
    secondList.add(tokens[1]);
  }

  firstList.sort();
  secondList.sort();

  int distance = 0;

  for (int i = 0; i < inputData.length; i++) {
    distance += (firstList[i] - secondList[i]).abs();
  }

  print("Total distance : $distance");
}
