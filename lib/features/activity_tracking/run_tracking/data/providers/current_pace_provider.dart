import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_pace_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentPace extends _$CurrentPace {
  DateTime _lastUpdate = DateTime.now();
  @override
  Pace build() {
    return Pace(0, Duration.zero);
  }

  void updatePace(double distance) {
    DateTime currentTime = DateTime.now();
    Duration timeSinceUpdate = currentTime.difference(_lastUpdate);

    Pace newPace = Pace(distance, timeSinceUpdate);
    _lastUpdate = currentTime;
    state = newPace;
  }
}
