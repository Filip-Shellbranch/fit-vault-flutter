class Pace {
  final double distance; // In km.
  final Duration time;
  Pace(this.distance, this.time);

  String asMinsPerKm() {
    if (distance == 0) {
      return "0:00";
    }
    int secPerKm = (time.inSeconds.toDouble() / distance).round();
    int wholeMins = (secPerKm / 60).floor();
    int seconds = secPerKm - 60 * wholeMins;
    return "$wholeMins:$seconds";
  }
}
