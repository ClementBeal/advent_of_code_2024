import 'package:test/test.dart';

import '../bin/2/main.dart';

void main() {
  final testData = [
    ([7, 6, 4, 2, 1], true, true),
    ([1, 2, 7, 8, 9], false, false),
    ([9, 7, 6, 2, 1], false, false),
    ([1, 3, 2, 4, 5], false, true),
    ([8, 6, 4, 4, 1], false, true),
    ([1, 3, 6, 7, 9], true, true),
  ];

  for (var data in testData) {
    test(
      data.$1,
      () {
        expect(isSafeReport(data.$1), data.$2);
        expect(isSafeReportWithToleration(data.$1), data.$3);
      },
    );
  }
}
