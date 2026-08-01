import 'package:flutter/foundation.dart';

void dPrint(String str) {
  if (kDebugMode) {
    debugPrint(str);
  }
}
