import 'dart:io';

void main() {
  final inputData = File("inputs/2.txt").readAsLinesSync();

  int numberSafeReport = 0;
  int numberSafeReportWithToleration = 0;

  for (final line in inputData) {
    final tokens = line.split(" ").map(int.parse).toList();

    bool isSafe = isSafeReport(tokens);
    bool isSafe2 = isSafeReportWithToleration(tokens);

    numberSafeReport += (isSafe) ? 1 : 0;
    numberSafeReportWithToleration += (isSafe2) ? 1 : 0;
  }

  print("Number of safe reports : $numberSafeReport");
  print("Number of tolerared safe reports : $numberSafeReportWithToleration");
}

bool isSafeReport(List<int> levels) {
  bool? isIncreasing;

  for (int i = 0; i < levels.length - 1; i++) {
    int diff = levels[i] - levels[i + 1];

    if (diff.abs() < 1 || diff.abs() > 3) {
      return false;
    }

    if (isIncreasing == null) {
      isIncreasing = diff > 0;
    } else if (!(isIncreasing && diff > 0) && !(!isIncreasing && diff < 0)) {
      return false;
    }
  }

  return true;
}

bool isSafeReportWithToleration(List<int> levels) {
  bool isSafe = isSafeReport(levels);

  if (!isSafe) {
    for (int i = 0; i < levels.length; i++) {
      final copy = [...levels];
      copy.removeAt(i);
      if (isSafeReport(copy)) {
        return true;
      }
    }

    return false;
  }

  return isSafe;
}
