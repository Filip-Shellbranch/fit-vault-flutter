import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:flutter/foundation.dart';

void dPrint(String str) {
  if (kDebugMode || kProfileMode) {
    debugPrint(str);
  }
}

void dInfo(String str) {
  dPrint(str);
  AppLogger().info(str);
}

void dWarn(String str) {
  dPrint(str);
  AppLogger().warning(str);
}

void dError(String message, {Object? error, StackTrace? stack}) {
  dPrint(message);
  if (error != null) {
    dPrint(error.toString());
  }
  if (stack != null) {
    dPrint(stack.toString());
  }
  AppLogger().error(message, error: error, stackTrace: stack);
}
