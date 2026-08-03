import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/core/database/isar_service.dart';
import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/home_page/views/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = AppLogger();
  await logger.init(); // Initializes app-wide singleton used to log to a file.

  final isarService = IsarService();
  await isarService.init();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.error(
      "Flutter error occured",
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    );
    return true;
  };

  FlutterForegroundTask.initCommunicationPort();
  if (kDebugMode) {
    if (await ForegroundServiceController().isRunning()) {
      await FlutterForegroundTask.stopService();
    }
  }
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: "run_tracking",
      channelName: "run_tracking",
      priority: NotificationPriority.MAX,
    ),
    iosNotificationOptions: IOSNotificationOptions(),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.nothing(),
      allowWakeLock: true,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarService.db)],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          highlightColor: Color(0xffdf7315),
          primaryColor: Color(0xff035fa1),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
        ),

        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
