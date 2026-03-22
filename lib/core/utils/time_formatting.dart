String format24h(DateTime time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
}

String formatDurationMinutesSeconds(Duration duration) {
  // Use inSegments to get absolute totals
  String minutes = duration.inMinutes.remainder(60).toString();
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  return "$minutes:$seconds";
}
