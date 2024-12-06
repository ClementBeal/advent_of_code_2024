import 'dart:io';
import 'dart:typed_data';

void main(List<String> args) {
  final input = File(r"inputs/6.txt").readAsLinesSync();

  print(simulateGuardMovement(input.map((line) => line.split("")).toList()));
}

typedef Dimension = ({int x, int y});
typedef Position = ({int x, int y});
typedef RoomMap = List<List<String>>;

enum Direction { east, west, north, south }

int simulateGuardMovement(RoomMap roomMap) {
  final Dimension dimension = (x: roomMap[0].length, y: roomMap.length);
  final map = convertToMap(roomMap);

  Dimension guardPosition = findGuard(map, dimension);

  Set<Dimension> cache = {guardPosition};

  while (isInside(dimension, guardPosition)) {
    guardPosition = move(map, dimension, guardPosition);

    if (isInside(dimension, guardPosition)) {
      cache.add(guardPosition);
    }

    print(guardPosition);
  }

  return cache.length;
}

Uint8List convertToMap(RoomMap map) {
  final list = Uint8List(map.length * map[0].length);

  final xLength = map[0].length;
  final yLength = map.length;

  for (int x = 0; x < xLength; x++) {
    for (int y = 0; y < yLength; y++) {
      final cellValue = map[y][x];
      final id = x + xLength * y;

      switch (cellValue) {
        case ">":
          list[id] = 0;
          break;
        case "<":
          list[id] = 1;
          break;
        case "^":
          list[id] = 2;
          break;
        case "v":
          list[id] = 3;
          break;
        case ".":
          list[id] = 4;
          break;
        case "#":
          list[id] = 5;
          break;
      }
    }
  }

  return list;
}

Position findGuard(Uint8List map, Dimension dimension) {
  for (var i = 0; i < map.length; i++) {
    if (map[i] < 4) return (x: i % dimension.x, y: i ~/ dimension.x);
  }

  throw Exception("No guard");
}

bool isInside(Dimension dimension, Position position) {
  return 0 <= position.x &&
      position.x < dimension.x &&
      0 <= position.y &&
      position.y < dimension.y;
}

int? getCellValue(Uint8List map, Dimension dimension, Position position) {
  if (!isInside(dimension, position)) return null;

  return map[position.x + position.y * dimension.x];
}

void setCellValue(
    Uint8List map, Dimension dimension, Position position, int value) {
  if (!isInside(dimension, position)) return;

  map[position.x + position.y * dimension.x] = value;
}

Position move(Uint8List map, Dimension dimension, Position position) {
  final currentValue = getCellValue(map, dimension, position);
  final currentDirection = switch (currentValue) {
    0 => Direction.east,
    1 => Direction.west,
    2 => Direction.north,
    3 => Direction.south,
    _ => Direction.east,
  };

  final facingCellPosition = switch (currentDirection) {
    Direction.east => (x: position.x + 1, y: position.y),
    Direction.west => (x: position.x - 1, y: position.y),
    Direction.north => (x: position.x, y: position.y - 1),
    Direction.south => (x: position.x, y: position.y + 1),
  };

  final facingCellValue = getCellValue(map, dimension, facingCellPosition);

  if (facingCellValue == null) {
    return facingCellPosition;
  } else {
    if (facingCellValue == 5) {
      // we rotate
      setCellValue(
          map,
          dimension,
          position,
          switch (currentDirection) {
            Direction.east => 3,
            Direction.west => 2,
            Direction.north => 0,
            Direction.south => 1,
          });
      return position;
    } else {
      setCellValue(
        map,
        dimension,
        facingCellPosition,
        currentValue!,
      );

      setCellValue(
        map,
        dimension,
        position,
        4,
      );

      return facingCellPosition;
    }
  }
}
