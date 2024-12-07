import 'package:test/test.dart';

import '../bin/6/main.dart';
import '../bin/7/main.dart';

void main() {
  final testInput = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20""";

  test("day 7 part 1", () {
    final input = testInput.split("\n").toList();

    final totalMove = findCorrectEquations(input);

    expect(totalMove, 3749);
  });
}
