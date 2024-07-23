extension StringToDateTime on String {
  DateTime toDateTime() {
    final parts = split('-');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format. Expected yyyy-MM-dd');
    }

    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}
