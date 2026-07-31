import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activityControllerProvider = Provider<ActivityController>((ref) {
  return ActivityController(ref);
});
