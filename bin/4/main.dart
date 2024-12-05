import 'dart:io';

import 'package:collection/collection.dart';

const sequence = ["X", "M", "A", "S"];
const shortSequence = ["M", "A", "S"];
const eq = ListEquality();

void main(List<String> args) {
  final input = File(r"inputs/4.txt")
      .readAsLinesSync()
      .map((line) => line.split(""))
      .toList();

  print(countXMAS(input));
  print(countXMAS2(input));
}

int countXMAS(List<List<String>> lines) {
  int xLength = lines[0].length;
  int yLength = lines.length;

  int total = 0;

  for (int x = 0; x < xLength; x++) {
    for (int y = 0; y < yLength; y++) {
      int totalCombinaison = (hasTopDown(lines, x, y) ? 1 : 0) +
          (hasDownTop(lines, x, y) ? 1 : 0) +
          (hasLeftRight(lines, x, y) ? 1 : 0) +
          (hasRightLeft(lines, x, y) ? 1 : 0) +
          (hasDiagonalTopLeftBottomRight(lines, x, y) ? 1 : 0) +
          (hasDiagonalBottomRightTopLeft(lines, x, y) ? 1 : 0) +
          (hasDiagonalTopRightBottomLeft(lines, x, y) ? 1 : 0) +
          (hasDiagonalBottomLeftTopRight(lines, x, y) ? 1 : 0);

      total += totalCombinaison;
    }
  }

  return total ~/ 4;
}

int countXMAS2(List<List<String>> lines) {
  int xLength = lines[0].length;
  int yLength = lines.length;

  int total = 0;

  for (int x = 1; x < xLength - 1; x++) {
    for (int y = 1; y < yLength - 1; y++) {
      bool isX = isOnBackslashDiag(lines, x, y) && isOnSlashDiag(lines, x, y);
      total += (isX) ? 1 : 0;
    }
  }

  return total;
}

String getChar(List<List<String>> lines, int x, int y) {
  int xLength = lines[0].length;
  int yLength = lines.length;

  if (x < 0 || x >= xLength) return "";
  if (y < 0 || y >= yLength) return "";

  return lines[y][x];
}

bool hasTopDown(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0; i < 4; i++) getChar(lines, x, y + i - pos)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasDownTop(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);
  final getSequence = [
    for (int i = y + pos; i > y - (4 - pos); i--) getChar(lines, x, i)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasLeftRight(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0; i < 4; i++) getChar(lines, x + i - pos, y)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasRightLeft(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = x + pos; i > x - (4 - pos); i--) getChar(lines, i, y)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasDiagonalTopLeftBottomRight(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0 - pos; i < 4 - pos; i++) getChar(lines, x + i, y + i)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasDiagonalTopRightBottomLeft(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0 - pos; i < 4 - pos; i++) getChar(lines, x - i, y + i)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasDiagonalBottomLeftTopRight(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0 - pos; i < 4 - pos; i++) getChar(lines, x + i, y - i)
  ];

  return eq.equals(getSequence, sequence);
}

bool hasDiagonalBottomRightTopLeft(List<List<String>> lines, int x, int y) {
  final current = getChar(lines, x, y);
  final pos = sequence.indexOf(current);

  final getSequence = [
    for (int i = 0 - pos; i < 4 - pos; i++) getChar(lines, x - i, y - i)
  ];

  return eq.equals(getSequence, sequence);
}

bool isOnBackslashDiag(List<List<String>> lines, int x, int y) {
  String previousChar = getChar(lines, x - 1, y - 1);
  String nextChar = getChar(lines, x + 1, y + 1);
  final currentChar = getChar(lines, x, y);

  return eq.equals([previousChar, currentChar, nextChar], shortSequence) ||
      eq.equals([nextChar, currentChar, previousChar], shortSequence);
}

bool isOnSlashDiag(List<List<String>> lines, int x, int y) {
  String previousChar = getChar(lines, x - 1, y + 1);
  String nextChar = getChar(lines, x + 1, y - 1);
  final currentChar = getChar(lines, x, y);

  return eq.equals([previousChar, currentChar, nextChar], shortSequence) ||
      eq.equals([nextChar, currentChar, previousChar], shortSequence);
}
