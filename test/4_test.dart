import 'package:test/test.dart';

import '../bin/4/main.dart';

void main() {
  test(
    "day 4 part 1",
    () {
      final input = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX""";

      expect(
          countXMAS(input.split("\n").map((line) => line.split("")).toList()),
          18);
    },
  );

  group(
    "Sequence checker",
    () {
      test(
        "top down",
        () {
          final lines = [
            ["M"],
            ["A"],
            ["M"],
            ["X"],
            ["M"],
            ["A"],
            ["S"],
            ["A"],
            ["M"],
            ["X"],
          ];

          expect(hasTopDown(lines, 0, 0), false);
          expect(hasTopDown(lines, 0, 1), false);
          expect(hasTopDown(lines, 0, 2), false);
          expect(hasTopDown(lines, 0, 3), true);
          expect(hasTopDown(lines, 0, 4), true);
          expect(hasTopDown(lines, 0, 5), true);
          expect(hasTopDown(lines, 0, 6), true);
          expect(hasTopDown(lines, 0, 7), false);
          expect(hasTopDown(lines, 0, 8), false);
          expect(hasTopDown(lines, 0, 9), false);
        },
      );

      test(
        "top down bigger",
        () {
          final lines = [
            ["X"],
            ["M"],
            ["A"],
            ["S"],
          ];

          expect(hasTopDown(lines, 0, 0), true);
          expect(hasTopDown(lines, 0, 1), true);
          expect(hasTopDown(lines, 0, 2), true);
          expect(hasTopDown(lines, 0, 3), true);
        },
      );

      test(
        "top down",
        () {
          final lines = [
            ["S"],
            ["A"],
            ["M"],
            ["X"],
          ];

          expect(hasDownTop(lines, 0, 0), true);
          expect(hasDownTop(lines, 0, 1), true);
          expect(hasDownTop(lines, 0, 2), true);
          expect(hasDownTop(lines, 0, 3), true);
        },
      );

      test(
        "left right",
        () {
          final lines = [
            ["X", "M", "A", "S"],
          ];

          expect(hasLeftRight(lines, 0, 0), true);
          expect(hasLeftRight(lines, 1, 0), true);
          expect(hasLeftRight(lines, 2, 0), true);
          expect(hasLeftRight(lines, 3, 0), true);
        },
      );

      test(
        "right left",
        () {
          final lines = [
            ["S", "A", "M", "X"],
          ];

          expect(hasRightLeft(lines, 0, 0), true);
          expect(hasRightLeft(lines, 1, 0), true);
          expect(hasRightLeft(lines, 2, 0), true);
          expect(hasRightLeft(lines, 3, 0), true);
        },
      );
      test(
        "diag top left bottom right",
        () {
          final lines = [
            ["X", "", "", ""],
            ["", "M", "", ""],
            ["", "", "A", ""],
            ["", "", "", "S"],
          ];

          expect(hasDiagonalTopLeftBottomRight(lines, 0, 0), true);
          expect(hasDiagonalTopLeftBottomRight(lines, 1, 1), true);
          expect(hasDiagonalTopLeftBottomRight(lines, 2, 2), true);
          expect(hasDiagonalTopLeftBottomRight(lines, 3, 3), true);
        },
      );

      test(
        "diag bottom right -> top left",
        () {
          final lines = [
            ["S", "", "", ""],
            ["", "A", "", ""],
            ["", "", "M", ""],
            ["", "", "", "X"],
          ];

          expect(hasDiagonalBottomRightTopLeft(lines, 3, 3), true);
          expect(hasDiagonalBottomRightTopLeft(lines, 2, 2), true);
          expect(hasDiagonalBottomRightTopLeft(lines, 1, 1), true);
          expect(hasDiagonalBottomRightTopLeft(lines, 0, 0), true);
        },
      );

      test(
        "diag top right bottom left",
        () {
          final lines = [
            ["", "", "", "X"],
            ["", "", "M", ""],
            ["", "A", "", ""],
            ["S", "", "", ""],
          ];

          expect(hasDiagonalTopRightBottomLeft(lines, 3, 0), true);
          expect(hasDiagonalTopRightBottomLeft(lines, 2, 1), true);
          expect(hasDiagonalTopRightBottomLeft(lines, 1, 2), true);
          expect(hasDiagonalTopRightBottomLeft(lines, 0, 3), true);
        },
      );

      test(
        "diag top right bottom left",
        () {
          final lines = [
            ["", "", "", "S"],
            ["", "", "A", ""],
            ["", "M", "", ""],
            ["X", "", "", ""],
          ];

          expect(hasDiagonalBottomLeftTopRight(lines, 0, 3), true);
          expect(hasDiagonalBottomLeftTopRight(lines, 1, 2), true);
          expect(hasDiagonalBottomLeftTopRight(lines, 2, 1), true);
          expect(hasDiagonalBottomLeftTopRight(lines, 3, 0), true);
        },
      );
    },
  );
}
