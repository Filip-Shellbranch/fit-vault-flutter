String format24h(DateTime time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
}

String formatDurationMinutesSeconds(Duration duration) {
  String minutes = duration.inMinutes.remainder(60).toString();
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  return "$minutes:$seconds";
}

String formatDurationHMS(Duration duration) {
  String pad(int segment) {
    return segment.toString().padLeft(2, "0");
  }

  int hourSegment = duration.inHours;
  int minuteSegment = duration.inMinutes.remainder(60);
  int secondSegment = duration.inSeconds.remainder(60);
  if (hourSegment > 0) {
    return "${hourSegment.toString()}:${pad(minuteSegment)}:${pad(secondSegment)}";
  } else {
    return "$minuteSegment:${pad(secondSegment)}";
  }
}
