import 'dart:math';

import 'package:test/test.dart';

import '../bin/3/main.dart';

void main() {
  test(
    "day 3 part 1",
    () {
      final input =
          "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";

      expect(multiplyProgram(input), 161);
    },
  );

  test(
    "day 3 part 2",
    () {
      final input =
          "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

      expect(multiplyProgram(input), 48);
    },
  );
}
