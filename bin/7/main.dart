import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

void main(List<String> args) {
  final input = File(r"inputs/7.txt").readAsLinesSync();

  print(findCorrectEquations(input));
}

int findCorrectEquations(List<String> lines) {
  int total = 0;

  for (var line in lines) {
    final tokens = line.split(":");

    final expectedResult = int.parse(tokens[0]);
    final coeffiecents = tokens[1]
        .split(" ")
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .map(int.parse)
        .toList();

    final operators = Uint8List(coeffiecents.length - 1);

    int possibleCombination = pow(2, operators.length).toInt();

    for (var i = 0; i < possibleCombination; i++) {
      int equationResult = coeffiecents[0];

      for (var (index, operator) in operators.indexed) {
        equationResult = (operator == 0)
            ? equationResult + coeffiecents[index + 1]
            : equationResult * coeffiecents[index + 1];
      }

      if (equationResult == expectedResult) {
        total += expectedResult;
        break;
      }

      incrementUint8List(operators);
    }
  }

  return total;
}

void incrementUint8List(Uint8List list) {
  int reminder = 0;
  int i = 0;

  reminder = list[i] == 1 ? 1 : 0;
  list[i] = list[i] == 1 ? 0 : 1;

  i++;

  while (reminder != 0 && i < list.length) {
    reminder = list[i] == 1 ? 1 : 0;
    list[i] = list[i] == 1 ? 0 : 1;

    i++;
  }
}
