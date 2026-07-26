import 'package:intl/intl.dart';

String format24h(DateTime time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
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

String formatDate(DateTime date) {
  final formatted = DateFormat('dd MMM yyyy HH:mm').format(date);
  return formatted;
}
