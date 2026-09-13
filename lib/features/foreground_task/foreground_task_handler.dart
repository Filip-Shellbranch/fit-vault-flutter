import 'dart:io';
import 'dart:isolate';

import 'package:fit_vault_flutter/core/database/isar_service.dart';
import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

class RunHandler {
  Run? activeRun;
  final RunRepository runRepository;
  final GeoLocationRepository geo = GeoLocationRepository();

  RunHandler(Isar db) : runRepository = RunRepository(db);

  Future<void> init() async {
    activeRun = await runRepository.getActiveRun();
    dInfo("RunHandler - Active run: ${activeRun.toString()}");
  }

  void dispose() {
    geo.dispose();
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
      }
    } catch (e, stack) {
      dError(
        "Error updating run with new GPS position.",
        error: e,
        stack: stack,
      );
    }
  }

  void pauseRun() async {
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
    runRepository.saveRun(run, onlyAddNewPoints: true);
    geo.startStream(_onNewPosition);
  }

  void stopRun() {
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

    bool success = await runRepository.deleteRun(id);
    if (success) {
      dInfo("Deleted current run with id: $id");
    } else {
      dWarn("Could not delete current run with id: $id");
    }
  }
}

class ForegroundTaskHandler extends TaskHandler {
  late ReceivePort errorPort;
  IsarService dbService = IsarService();
  late RunHandler runHandler;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    await AppLogger().init(fileName: "foreground.log");

    dWarn(
      "FG TASK STARTED "
      "${DateTime.now()} "
      "pid=$pid "
      "isolate=${Isolate.current.hashCode}",
    );

    try {
      _addErrorHandling();
      await dbService.init();

      runHandler = RunHandler(dbService.db);
      await runHandler.init();

      /* LocationRequestResult permission = await geo.initialize();
      if (permission == LocationRequestResult.granted) {
        await geo.startStream(onNewPosition);
      }*/
    } catch (e) {
      dError("Error starting ForegroundTaskHandler", error: e);
    }
  }

  void _addErrorHandling() {
    errorPort = ReceivePort();

    Isolate.current.addErrorListener(errorPort.sendPort);
    Isolate.current.addOnExitListener(errorPort.sendPort);

    errorPort.listen((dynamic error) {
      if (error is List) {
        dError(
          "Foreground isolate error",
          error: error[0],
          stack: StackTrace.fromString(error[1]),
        );
      } else {
        dError("Foreground isolate exited", error: error);
      }
    });
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    //TODO: Revert if activity stops unexpectedly.
    dInfo("Foreground task alive");
  }

  @override
  void onReceiveData(Object data) {
    super.onReceiveData(data);

    bool isJSON = data is Map<String, dynamic>;
    if (!isJSON) {
      dWarn("Invalid JSON received: ${data.toString()}");
      return;
    }
    TaskCommand command = TaskCommand.fromJSON(data);
    dInfo("Received command: ${command.toString()}");
    switch (command) {
      case StartRunCommand():
        runHandler.startNewRun();
        break;
      case BeginRunCommand():
        runHandler.beginRun();
        break;
      case PauseRunCommand():
        runHandler.pauseRun();
        break;
      case ResumeRunCommand():
        runHandler.resumeRun();
        break;
      case StopRunCommand():
        runHandler.stopRun();
        break;
      case DiscardRunCommand():
        runHandler.discardRun();
        break;
      default:
    }

    /*bool isJSON = data is Map<String, dynamic>;
    if (!isJSON) {
      dWarn("Invalid JSON received: ${data.toString()}");
      return;
    }
    try {
      TaskCommand cmd = TaskCommand.fromJSON(data);
      ForegroundServiceController().updateService(cmd);
    } catch (e, trace) {
      dError(
        "Error parsing command or updating notification",
        error: e,
        stack: trace,
      );
    }*/
  }

  @override
  void onNotificationButtonPressed(String id) {
    try {
      switch (id) {
        case "resume":
          FlutterForegroundTask.sendDataToMain(id);
          break;
        case "pause":
          FlutterForegroundTask.sendDataToMain(id);
          break;
        case "stop":
          FlutterForegroundTask.sendDataToMain(id);
          break;
        default:
      }
    } catch (e, stack) {
      dError("Error when pressing notification button", error: e, stack: stack);
    }
    super.onNotificationButtonPressed(id);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/service_lifecycle.log');
    dWarn("FOREGROUND SERVICE DESTROYED timeout=$isTimeout");

    runHandler.dispose();

    await file.writeAsString(
      "${DateTime.now()} onDestroy, timeout: ${isTimeout.toString()}\n",
      mode: FileMode.append,
      flush: true,
    );
    try {
      //  await geo.dispose();
      errorPort.close();
    } catch (e, stack) {
      dError("Error destroying task handler", error: e, stack: stack);
    }
  }
}
