import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_tracking_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final runTrackingServiceProvider = Provider((ref) {
  final service = RunTrackingService(ref);
  ref.onDispose(service.dispose);
  return service;
});
