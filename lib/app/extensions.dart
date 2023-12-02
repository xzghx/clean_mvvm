extension NonNullString on String? {
  String orEmpty() {
    return this ?? '';
  }
}

extension NonNullInt on int? {
  int orZero() {
    return this ?? 0;
  }
}
