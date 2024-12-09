import 'dart:io';
import 'dart:typed_data';

Future<void> main(List<String> args) async {
  final input = File(r"inputs/9.txt").readAsStringSync();

  print(calculateChecksum(input));
  print(calculateChecksumWithoutFragmentation(input));
}

int calculateChecksum(String disk) {
  int max = 64000;
  int total = 0;
  for (var i = 0; i < disk.length; i++) {
    total += int.parse(disk[i]);
  }

  final list = Uint16List(total);

  int j = 0;

  bool isBlock = true;
  int blockId = 0;

  for (var i = 0; i < disk.length; i++) {
    final int value = int.parse(disk[i]);
    final limit = value + j;

    if (isBlock) {
      for (; j < limit; j++) {
        list[j] = blockId;
      }
      blockId++;
    } else {
      for (; j < limit; j++) {
        list[j] = max;
      }
    }

    isBlock = !isBlock;
  }

  int leftCursor = 0;
  int rightCursor = list.length - 1;

  while (leftCursor < rightCursor) {
    if (list[leftCursor] == max) {
      list[leftCursor] = list[rightCursor];
      list[rightCursor] = max;
      rightCursor--;
    } else {
      leftCursor++;
    }
  }

  int checksum = 0;
  for (var i = 0; i < rightCursor + 1; i++) {
    checksum += list[i] * i;
  }

  return checksum;
}

int calculateChecksumWithoutFragmentation(String disk) {
  int max = 64000;
  int total = 0;

  for (int i = 0; i < disk.length; i++) {
    total += int.parse(disk[i]);
  }

  final original = Uint16List(disk.length);
  final list = Uint16List(total);

  int j = 0;

  bool isBlock = true;
  int blockId = 0;

  for (var i = 0; i < disk.length; i++) {
    final int value = int.parse(disk[i]);
    original[i] = value;

    final limit = value + j;

    if (isBlock) {
      for (; j < limit; j++) {
        list[j] = blockId;
      }
      blockId++;
    } else {
      for (; j < limit; j++) {
        list[j] = max;
      }
    }

    isBlock = !isBlock;
  }

  int leftCursor = 0;
  int rightCursor = list.length - 1;

  while (0 < rightCursor) {
    leftCursor = 0;

    while (list[rightCursor] == max) {
      rightCursor--;
      if (rightCursor < 0) break;
    }

    int currentValue = list[rightCursor];

    int length = 0;

    while (list[rightCursor - length] == currentValue) {
      length++;
      if (rightCursor - length < 0) break;
    }

    int freeSpace = 0;

    while (freeSpace < length && leftCursor < rightCursor) {
      if (list[leftCursor] == max) {
        freeSpace++;
      } else {
        freeSpace = 0;
      }

      leftCursor++;
    }
    leftCursor--;

    if (freeSpace == length && leftCursor < rightCursor) {
      for (var i = 0; i < length; i++) {
        list[leftCursor - i] = currentValue;
      }

      for (var i = 0; i < length; i++) {
        list[rightCursor - i] = max;
      }
    }

    rightCursor -= length;
  }

  int checksum = 0;

  for (var i = 0; i < list.length - 1; i++) {
    if (list[i] != max) {
      checksum += list[i] * i;
    }
  }

  return checksum;
}
