class Pace {
  final double distance; // In km.
  final Duration time;
  Pace(this.distance, this.time);

  factory Pace.fromMps(double metersPerSecond) {
    return Pace(metersPerSecond / 1000, Duration(seconds: 1));
  }

  String asMinsPerKm() {
    if (distance <= 0 || time.inSeconds <= 0) {
      return "0:00";
    }
    int secPerKm = (time.inSeconds / distance).round();
    int wholeMins = (secPerKm / 60).floor();
    int seconds = secPerKm - 60 * wholeMins;

    return "$wholeMins:${seconds < 10 ? "0$seconds" : seconds}";
  }

  double get metersPerSecond {
    return (distance * 1000) / (time.inMilliseconds / 1000);
  }

  @override
  String toString() {
    return "$distance km : ${time.inSeconds} seconds";
  }
}
