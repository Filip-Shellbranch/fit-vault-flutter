import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_run_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'displayed_run_provider.g.dart';

@riverpod
Run? displayedRun(Ref ref) {
  final editedRun = ref.watch(editedRunProvider);
  if (editedRun != null) {
    return editedRun;
  }
  final currentRun = ref.watch(currentRunProvider).value;
  return currentRun;
}
