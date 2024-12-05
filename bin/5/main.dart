import 'dart:io';

void main(List<String> args) {
  final input = File(r"inputs/5.txt").readAsLinesSync();

  final rules = parseRules(input);

  print(checkCorrectPages(rules));
  print(checkInCorrectPages(rules));
}

typedef A = (Map<int, List<int>>, List<List<int>>);

int checkCorrectPages(A a) {
  final orders = a.$2;
  final rules = a.$1;

  int total = 0;

  for (final line in orders) {
    total += analyzeLine(line, rules);
  }

  return total;
}

int checkInCorrectPages(A a) {
  final orders = a.$2;
  final rules = a.$1;

  int total = 0;

  for (final line in orders) {
    total += analyzeIncorrectLine(line, rules);
  }

  return total;
}

A parseRules(List<String> lines) {
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

  return (rules, orders);
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

int analyzeIncorrectLine(
  List<int> line,
  Map<int, List<int>> rules,
) {
  for (final (index, number) in line.indexed) {
    for (var i = index + 1; i < line.length; i++) {
      final nextNumber = line[i];

      if (rules[nextNumber]?.contains(number) ?? false) {
        line.sort(
          (a, b) {
            if (rules[a]?.contains(b) ?? false) {
              return -1;
            }
            if (rules[b]?.contains(a) ?? false) {
              return 1;
            }

            return 0;
          },
        );

        return line[((line.length - 1) ~/ 2)];
      }
    }
  }

  return 0;
}
