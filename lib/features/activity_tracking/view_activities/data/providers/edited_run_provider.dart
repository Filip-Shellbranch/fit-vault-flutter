import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edited_run_provider.g.dart';

@riverpod
class EditedRun extends _$EditedRun {
  @override
  Run? build() {
    return null;
  }

  void beginEdit(Run run) {
    state = run;
  }

  void stopEdit() {
    state = null;
  }
}
