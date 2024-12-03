import 'dart:io';

void main(List<String> args) {
  final input = File(r"inputs/3.txt").readAsStringSync();

  print(multiplyProgram(input));
}

int multiplyProgram(String input) {
  final doRegex = r"do\(\)";
  final dontRegex = r"don\'t\(\)";
  final multiplicationRegex = r"mul\((\d+),(\d+)\)";
  final regex = RegExp("($doRegex)|($dontRegex)|($multiplicationRegex)");

  final matches = regex.allMatches(input);

  int total = 0;
  bool canMultiply = true;

  for (final match in matches) {
    if (match.group(0) == "do()") {
      canMultiply = true;
    } else if (match.group(0) == "don't()") {
      canMultiply = false;
    } else {
      if (canMultiply) {
        total += int.parse(match.group(4)!) * int.parse(match.group(5)!);
      }
    }
  }

  return total;
}
