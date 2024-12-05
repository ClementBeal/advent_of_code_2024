import 'package:test/test.dart';

import '../bin/5/main.dart';

void main() {
  final testInput = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47""";

  test("day 5 part 1", () {
    final rules = parseRules(testInput.split("\n"));
    expect(checkCorrectPages(rules), 143);
  });

  test("day 5 part 2", () {
    final rules = parseRules(testInput.split("\n"));
    expect(checkInCorrectPages(rules), 123);
  });
}
