import 'package:test/test.dart';

import '../bin/8/main.dart';
import '../bin/9/main.dart';

void main() {
  test("day 9 part 1", () {
    final input = "2333133121414131402";

    expect(calculateChecksum(input), 1928);
  });

  test("day 9 part 2", () {
    final input = "2333133121414131402";

    expect(calculateChecksumWithoutFragmentation(input), 2858);
  });
}
