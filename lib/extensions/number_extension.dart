extension NumberExtension on int {
  String timeToString() {
    if (this < 10) return '0$this';
    return '$this';
  }
}
