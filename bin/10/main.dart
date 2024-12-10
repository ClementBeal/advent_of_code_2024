import 'dart:io';
import 'dart:typed_data';

Future<void> main(List<String> args) async {
  final input = File(r"inputs/10.txt").readAsLinesSync();

  print(countTrailheads(input));
}

typedef Position = ({int x, int y});

int countTrailheads(List<String> lines) {
  final grid = Uint8List(lines[0].length * lines.length);

  final startPositions = <Position>{};

  for (var y = 0; y < lines.length; y++) {
    for (var x = 0; x < lines[0].length; x++) {
      grid[x + y * lines[0].length] = int.parse(lines[y][x]);

      if (grid[x + y * lines[0].length] == 0) {
        startPositions.add((x: x, y: y));
      }
    }
  }

  final xLength = lines[0].length;
  final yLength = lines.length;

  int trailheads = 0;

  for (final initialPosition in startPositions) {
    int value =
        _findTrailhead(initialPosition, grid, xLength, yLength, 0).length;

    // print(value);
    trailheads += value;
  }

  return trailheads;
}

Set<Position> _findTrailhead(Position initialPosition, Uint8List grid,
    int xLength, int yLength, int value) {
  // print("$value ($initialPosition)");
  if (value == 9) return {initialPosition};

  final topValue = grid.getTopValue(
    initialPosition.x,
    initialPosition.y,
    xLength,
    yLength,
  );
  final bottomValue = grid.getBottomValue(
    initialPosition.x,
    initialPosition.y,
    xLength,
    yLength,
  );
  final leftValue = grid.getLeftValue(
    initialPosition.x,
    initialPosition.y,
    xLength,
    yLength,
  );
  final rightValue = grid.getRightValue(
    initialPosition.x,
    initialPosition.y,
    xLength,
    yLength,
  );

  Set<Position> total = {};

  if (topValue != null && topValue == value + 1) {
    total.addAll(_findTrailhead(
      (x: initialPosition.x, y: initialPosition.y - 1),
      grid,
      xLength,
      yLength,
      topValue,
    ));
  }

  if (bottomValue != null && bottomValue == value + 1) {
    total.addAll(_findTrailhead(
      (x: initialPosition.x, y: initialPosition.y + 1),
      grid,
      xLength,
      yLength,
      bottomValue,
    ));
  }
  if (leftValue != null && leftValue == value + 1) {
    total.addAll(_findTrailhead(
      (x: initialPosition.x - 1, y: initialPosition.y),
      grid,
      xLength,
      yLength,
      leftValue,
    ));
  }
  if (rightValue != null && rightValue == value + 1) {
    total.addAll(_findTrailhead(
      (x: initialPosition.x + 1, y: initialPosition.y),
      grid,
      xLength,
      yLength,
      rightValue,
    ));
  }

  return total;
}

extension Grid on Uint8List {
  int? getTopValue(int x, int y, int xLength, int yLength) {
    return (y - 1 >= 0) ? getValue(x, y - 1, xLength, yLength) : null;
  }

  int? getLeftValue(int x, int y, int xLength, int yLength) {
    return (x - 1 >= 0) ? getValue(x - 1, y, xLength, yLength) : null;
  }

  int? getBottomValue(int x, int y, int xLength, int yLength) {
    return (y + 1 < yLength) ? getValue(x, y + 1, xLength, yLength) : null;
  }

  int? getRightValue(int x, int y, int xLength, int yLength) {
    return (x + 1 < xLength) ? getValue(x + 1, y, xLength, yLength) : null;
  }

  int getValue(int x, int y, int xLength, int yLength) {
    return this[x + y * xLength];
  }
}
