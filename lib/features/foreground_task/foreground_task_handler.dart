import 'dart:io';
import 'dart:isolate';

import 'package:fit_vault_flutter/core/database/isar_service.dart';
import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:fit_vault_flutter/features/foreground_task/run_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:path_provider/path_provider.dart';

class ForegroundTaskHandler extends TaskHandler {
  late ReceivePort errorPort;
  IsarService dbService = IsarService();
  late RunTaskHandler runHandler;

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

      runHandler = RunTaskHandler(dbService.db);
      await runHandler.init();
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
  void onReceiveData(Object data) async {
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
        await runHandler.pauseRun();
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
  }

  @override
  void onNotificationButtonPressed(String id) {
    try {
      switch (id) {
        case "run: resume":
          runHandler.resumeRun();
          break;
        case "run: pause":
          runHandler.pauseRun();
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

    await file.writeAsString(
      "${DateTime.now()} onDestroy, timeout: ${isTimeout.toString()}\n",
      mode: FileMode.append,
      flush: true,
    );
    try {
      runHandler.dispose();
      errorPort.close();
    } catch (e, stack) {
      dError("Error destroying task handler", error: e, stack: stack);
    }
  }
}
