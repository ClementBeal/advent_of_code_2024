import 'package:test/test.dart';

import '../bin/10/main.dart';

void main() {
//   test("day 10 part 1", () {
//     final input = """
// 9990999
// 9991999
// 9992999
// 6543456
// 7111117
// 8111118
// 9111119"""
//         .split("\n");

//     expect(countTrailheads(input), 2);
//   });

  test("day 10 part 1 - 2", () {
    final input = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732"""
        .split("\n");

    expect(countTrailheads(input), 36);
  });
}
