import 'dart:async';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_repository.dart';
import 'package:fit_vault_flutter/features/foreground_task/notification_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isar_community/isar.dart';

class RunTaskHandler {
  Run? activeRun;
  Timer? _secondTicker;
  final RunRepository runRepository;
  final GeoLocationRepository geo = GeoLocationRepository();
  final NotificationService notif = NotificationService();

  RunTaskHandler(Isar db) : runRepository = RunRepository(db);

  Future<void> init() async {
    activeRun = await runRepository.getActiveRun();
    dInfo("RunHandler - Active run: ${activeRun.toString()}");
  }

  void _startTicker() {
    if (_secondTicker != null) {
      return;
    }
    _secondTicker = Timer.periodic(Duration(seconds: 1), (_) {
      if (activeRun == null) {
        return;
      } else {
        Run run = activeRun!;
        notif.updateRunNotification(run);
      }
    });
  }

  Future<void> _stopTicker() async {
    _secondTicker?.cancel();
    _secondTicker = null;
  }

  void dispose() {
    geo.dispose();
    _stopTicker();
  }

  Future<void> startNewRun() async {
    Run newRun = Run.newRun();
    activeRun = newRun;
    runRepository.saveRun(newRun);
  }

  void beginRun() async {
    Run? run = activeRun;
    if (run == null || run.isStarted()) {
      return;
    } else {
      run.state = RunState.active;
      run.startTime = DateTime.now();
      runRepository.saveRun(run, onlyAddNewPoints: true);
    }

    LocationRequestResult permission = await geo.initialize();
    if (permission == LocationRequestResult.granted) {
      await geo.startStream(_onNewPosition);
    }

    notif.updateRunNotification(run);
    _startTicker();
  }

  void _addNewPoint(Run run, RunPoint newPoint) {
    if (newPoint.type == PointType.active && run.isPaused()) {
      return;
    }
    run.addPoint(newPoint);
  }

  void _onNewPosition(Position position) {
    try {
      if (position.accuracy > 15) {
        dInfo("Low GPS accuracy, discarding point.");
        return;
      }
      final newPoint = RunPoint(
        position.latitude,
        position.longitude,
        DateTime.now(),
      );
      final run = activeRun;
      if (run != null) {
        _addNewPoint(run, newPoint);
        runRepository.saveRun(run, onlyAddNewPoints: true);
        notif.updateRunNotification(run);
      }
    } catch (e, stack) {
      dError(
        "Error updating run with new GPS position.",
        error: e,
        stack: stack,
      );
    }
  }

  Future<void> pauseRun() async {
    final run = activeRun;
    if (run == null) {
      return;
    }
    await geo.cancelStream();

    final now = DateTime.now();

    run.state = RunState.paused;
    run.pausedAt = now;
    Position? position = await geo.getCurrentPosition();
    if (position == null) {
      dWarn("Could not fetch current position!");
    } else {
      final newPoint = RunPoint(
        position.latitude,
        position.longitude,
        now,
        type: PointType.pause,
      );
      _addNewPoint(run, newPoint);
    }
    notif.updateRunNotification(run);
    await _stopTicker();
    runRepository.saveRun(run, onlyAddNewPoints: true);
  }

  void resumeRun() async {
    final run = activeRun;
    if (run == null) {
      return;
    }

    final now = DateTime.now();
    final pausedAt = run.pausedAt;
    if (pausedAt != null) {
      final pauseDuration = now.difference(pausedAt);
      run.pausedDuration += pauseDuration;
    }

    run.state = RunState.active;
    run.pausedAt = null;
    Position? position = await geo.getCurrentPosition();
    if (position == null) {
      dWarn("Could not fetch current position!");
    } else {
      final newPoint = RunPoint(
        position.latitude,
        position.longitude,
        now,
        type: PointType.resume,
      );
      _addNewPoint(run, newPoint);
    }
    notif.updateRunNotification(run);
    _startTicker();
    runRepository.saveRun(run, onlyAddNewPoints: true);
    geo.startStream(_onNewPosition);
  }

  Future<void> stopRun() async {
    final run = activeRun;
    if (run == null || run.positions.isEmpty) {
      return;
    }

    final lastPoint = run.positions.last;
    run.endTime = lastPoint.time;
    final newPoint = RunPoint(
      lastPoint.lat,
      lastPoint.lng,
      lastPoint.time,
      altitude: lastPoint.altitude,
      type: PointType.end,
    );
    _addNewPoint(run, newPoint);
    runRepository.saveRun(run, isCompleted: true, onlyAddNewPoints: true);
    notif.updateRunNotification(run);
    await _stopTicker();
  }

  void discardRun() async {
    final run = activeRun;
    if (run == null) {
      return;
    }

    final id = run.id;
    if (id == null) {
      return;
    }

    _stopTicker();
    bool success = await runRepository.deleteRun(id);
    if (success) {
      dInfo("Deleted current run with id: $id");
    } else {
      dWarn("Could not delete current run with id: $id");
    }
  }
}
