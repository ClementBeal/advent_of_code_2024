import 'dart:io';

void main(List<String> args) {
  final input = File(r"inputs/6.txt").readAsLinesSync();

  print(simulateGuardMovement(input.map((line) => line.split("")).toList()));

  final input2 = File(r"inputs/6.txt").readAsLinesSync();
  print(simulateGuardMovementWithObstruction(
      input2.map((line) => line.split("")).toList()));
}

typedef Position = ({int x, int y});
typedef RoomMap = List<List<String>>;

enum Direction { east, west, north, south }

int simulateGuardMovement(RoomMap map) {
  Position guardPosition = findGuard(map);

  Set<Position> cache = {guardPosition};

  while (isInside(map, guardPosition)) {
    guardPosition = move(map, guardPosition);

    if (isInside(map, guardPosition)) {
      cache.add(guardPosition);
    }
  }

  return cache.length;
}

int simulateGuardMovementWithObstruction(RoomMap map) {
  final initialPosition = findGuard(map);
  final initialDirection = findFacingDirection(
    getCellValue(map, initialPosition.x, initialPosition.y)!,
  );

  int total = 0;

  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[0].length; y++) {
      final cell = getCellValue(map, x, y);
      // print("$x $y");

      // we only want an empty cell
      if (cell != "." || (x: x, y: y) == initialPosition) continue;

      final copyMap = map.map((row) => List<String>.from(row)).toList();

      copyMap[x][y] = "O";

      Position guardPosition = (x: initialPosition.x, y: initialPosition.y);
      Direction direction = initialDirection;

      final history = <Position, List<Direction>>{
        guardPosition: [direction]
      };

      while (isInside(copyMap, guardPosition)) {
        guardPosition = move(copyMap, guardPosition);
        final newValue =
            getCellValue(copyMap, guardPosition.x, guardPosition.y);

        if (newValue != null) {
          direction = findFacingDirection(newValue);
        } else {
          break;
        }

        if (history[guardPosition]?.contains(direction) ?? false) {
          total += 1;
          break;
        } else {
          history.update(
            guardPosition,
            (value) => [...value, direction],
            ifAbsent: () => [direction],
          );
        }
      }
    }
  }

  return total;
}

Position findGuard(RoomMap map) {
  for (int x = 0; x < map[0].length; x++) {
    for (int y = 0; y < map.length; y++) {
      final cellValue = map[y][x];

      if ([">", "<", "^", "v"].contains(cellValue)) return (x: x, y: y);
    }
  }

  return (x: -1, y: -1);
}

bool isInside(RoomMap map, Position currentPosition) {
  return currentPosition.x >= 0 &&
      currentPosition.x < map[0].length &&
      currentPosition.y >= 0 &&
      currentPosition.y < map.length;
}

Direction findFacingDirection(String cellValue) {
  return switch (cellValue) {
    ">" => Direction.east,
    "<" => Direction.west,
    "v" => Direction.south,
    "^" => Direction.north,
    _ => Direction.east
  };
}

String? getCellValue(RoomMap map, int x, int y) {
  if (x < 0 || x >= map[0].length) return null;
  if (y < 0 || y >= map.length) return null;

  return map[y][x];
}

Position move(RoomMap map, Position currentPosition) {
  final cellValue = map[currentPosition.y][currentPosition.x];
  final direction = findFacingDirection(cellValue);

  final facingCellValue = switch (direction) {
    Direction.east =>
      getCellValue(map, currentPosition.x + 1, currentPosition.y),
    Direction.west =>
      getCellValue(map, currentPosition.x - 1, currentPosition.y),
    Direction.north =>
      getCellValue(map, currentPosition.x, currentPosition.y - 1),
    Direction.south =>
      getCellValue(map, currentPosition.x, currentPosition.y + 1),
  };

  // we rotat eby 90 deg clockwise
  if (facingCellValue == "#" || facingCellValue == "O") {
    map[currentPosition.y][currentPosition.x] = switch (direction) {
      Direction.east => "v",
      Direction.west => "^",
      Direction.north => ">",
      Direction.south => "<",
    };

    return currentPosition;
  } else {
    map[currentPosition.y][currentPosition.x] = ".";
    final newPosition = switch (direction) {
      Direction.east => (x: currentPosition.x + 1, y: currentPosition.y),
      Direction.west => (x: currentPosition.x - 1, y: currentPosition.y),
      Direction.north => (x: currentPosition.x, y: currentPosition.y - 1),
      Direction.south => (x: currentPosition.x, y: currentPosition.y + 1),
    };

    if (isInside(map, newPosition)) {
      map[newPosition.y][newPosition.x] = cellValue;
    }

    return newPosition;
  }
}
