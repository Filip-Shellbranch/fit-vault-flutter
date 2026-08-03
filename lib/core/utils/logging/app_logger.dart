import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:fit_vault_flutter/core/utils/logging/logger.dart';
import 'package:logger/logger.dart' hide FileOutput;

class AppLogger {
  AppLogger._privateConstructor();

  static final AppLogger _instance = AppLogger._privateConstructor();
  late final Logger _logger;
  bool _isInit = false;

  factory AppLogger() {
    return _instance;
  }

  Future<void> init({String fileName = "app.log"}) async {
    if (_isInit) {
      return;
    }
    final output = FileOutput(fileName);
    _logger = Logger(
      output: output,
      level: Level.trace,
      filter:
          ProductionFilter(), // Allows logging even in --profile and --release modes
    );
    await _logger.init;
    _isInit = true;
    dPrint("AppLogger initialized! Logs to $fileName");
  }

  void info(String message) => _logger.i(message);

  void warning(String message) => _logger.w(message);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
