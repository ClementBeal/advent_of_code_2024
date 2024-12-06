import 'dart:io';

void main(List<String> args) {
  final input = File(r"inputs/6.txt").readAsLinesSync();

  print(simulateGuardMovement(input.map((line) => line.split("")).toList()));
}

typedef Position = ({int x, int y});
typedef RoomMap = List<List<String>>;

enum Direction { east, west, north, south }

int simulateGuardMovement(RoomMap map) {
  Position guardPosition = findGuard(map);

  Set<Position> cache = {guardPosition};

  while (isInside(map, guardPosition)) {
    // print(map.map((line) => line.join()).join("\n"));
    // print("------------------------------");
    guardPosition = move(map, guardPosition);

    if (isInside(map, guardPosition)) {
      cache.add(guardPosition);
    }
  }

  return cache.length;
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

  if (facingCellValue == "#") {
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
