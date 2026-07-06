import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  @override
  Future<Run?> build() async {
    return null;
    //return ref.read(workoutRepositoryProvider).loadCurrentWorkout();
  }

  Future<void> startRun({Run? run}) async {
    run ??= Run(DateTime.now());

    state = AsyncValue.data(run);
  }
}
