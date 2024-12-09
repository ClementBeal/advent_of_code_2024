import 'dart:io';
import 'dart:typed_data';

Future<void> main(List<String> args) async {
  final input = File(r"inputs/9.txt").readAsStringSync();

  print(calculateChecksum(input));
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
