import 'dart:io';

void main(List<String> args) {
  final input = File(r"inputs/5.txt").readAsLinesSync();

  print(parseRules(input));
}

int parseRules(List<String> lines) {
  final it = lines.iterator;
  final rules = <int, List<int>>{};
  final List<List<int>> orders = [];

  bool addRule = true;

  while (it.moveNext()) {
    if (it.current == "") {
      addRule = false;
      continue;
    }

    if (addRule) {
      final [first, second] = it.current.split("|").map(int.parse).toList();
      rules.update(first, (value) => [...value, second],
          ifAbsent: () => [second]);
    } else {
      orders.add(it.current.split(",").map(int.parse).toList());
    }
  }

  int total = 0;

  for (final line in orders) {
    total += analyzeLine(line, rules);
  }

  return total;
}

int analyzeLine(
  List<int> line,
  Map<int, List<int>> rules,
) {
  for (final (index, number) in line.indexed) {
    for (var i = index + 1; i < line.length; i++) {
      final nextNumber = line[i];

      if (rules[nextNumber]?.contains(number) ?? false) {
        return 0;
      }
    }
  }

  return line[((line.length - 1) ~/ 2)];
}
