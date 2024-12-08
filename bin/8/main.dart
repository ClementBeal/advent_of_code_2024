import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';

Future<void> main(List<String> args) async {
  final input = File(r"inputs/8.txt").readAsLinesSync();

  print(countAntinodes(input));
}

typedef Position = ({int x, int y});

int countAntinodes(List<String> lines) {
  final antenas = <String, Set<Position>>{};
  final antinodes = <Position>{};

  final xLength = lines[0].length;
  final yLength = lines.length;

  bool isInside(Position position) =>
      position.x >= 0 &&
      position.y >= 0 &&
      position.x < xLength &&
      position.y < yLength;

  for (var x = 0; x < xLength; x++) {
    for (var y = 0; y < yLength; y++) {
      final value = lines[y][x];

      if (value != ".") {
        if (antenas.containsKey(value)) {
          antenas[value]!.add((x: x, y: y));
        } else {
          antenas[value] = {(x: x, y: y)};
        }
      }
    }
  }

  for (final entry in antenas.entries) {
    final positionsSet = entry.value;
    final positions = entry.value.toList();

    for (var i = 0; i < positions.length; i++) {
      final origin = positions[i];
      final others = positionsSet.difference({origin});

      for (final other in others) {
        final projection = project(origin, other);
        if (isInside(projection) &&
            lines[projection.y][projection.x] != entry.key) {
          // if (isInside(projection)) {
          antinodes.add(projection);
        }
      }
    }
  }

  // print(antenas);
  // print(antinodes);

  // for (var y = 0; y < yLength; y++) {
  //   final d = [];
  //   for (var x = 0; x < xLength; x++) {
  //     if (antinodes.contains((x: x, y: y))) {
  //       d.add("#");
  //     } else {
  //       d.add(lines[y][x]);
  //     }
  //   }

  //   print(d.join(""));
  // }

  return antinodes.length;
}

Position project(Position first, Position second) {
  int xDiff = second.x - first.x;
  int yDiff = second.y - first.y;

  return (
    x: second.x + xDiff,
    y: second.y + yDiff,
  );
}
