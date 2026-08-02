import 'package:fit_vault_flutter/core/utils/logging/logger.dart';
import 'package:logger/web.dart';

class AppLogger {
  AppLogger._privateConstructor();

  static final AppLogger _instance = AppLogger._privateConstructor();
  late final Logger _logger;
  bool _isInit = false;

  factory AppLogger() {
    return _instance;
  }

  Future<void> init() async {
    if (_isInit) {
      return;
    }
    final output = FileOutput();
    await output.init();
    _logger = Logger(output: output);
    _isInit = true;
  }

  void info(String message) => _logger.i(message);
  void warning(String message) => _logger.w(message);

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
