import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_run_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'displayed_run_provider.g.dart';

@riverpod
class DisplayedRun extends _$DisplayedRun {
  bool _isEditing = true;

  bool get isEditing => _isEditing;
  @override
  Run? build() {
    final editedRun = ref.watch(editedRunProvider);
    if (editedRun != null) {
      _isEditing = true;
      return editedRun;
    }
    _isEditing = false;
    final currentRun = ref.watch(currentRunProvider).value;
    return currentRun;
  }
}
