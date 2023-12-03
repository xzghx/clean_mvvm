import '../data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    return this ?? EMPTY;
  }
}

extension NonNullInt on int? {
  int orZero() {
    return this ?? ZERO;
  }
}
