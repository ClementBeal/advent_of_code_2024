import 'package:test/test.dart';

import '../bin/6/main.dart';

void main() {
  final testInput = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...""";

  final input = testInput
      .split("\n")
      .map(
        (line) => line.split(""),
      )
      .toList();

  test("day 6 part 1", () {
    final totalMove = simulateGuardMovement(input);

    expect(totalMove, 41);
  });
}
