// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentWorkout)
final currentWorkoutProvider = CurrentWorkoutProvider._();

final class CurrentWorkoutProvider
    extends $AsyncNotifierProvider<CurrentWorkout, Workout?> {
  CurrentWorkoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentWorkoutProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentWorkoutHash();

  @$internal
  @override
  CurrentWorkout create() => CurrentWorkout();
}

String _$currentWorkoutHash() => r'c1a326ef682baa6de0a3e8e2947620381f5c61ee';

abstract class _$CurrentWorkout extends $AsyncNotifier<Workout?> {
  FutureOr<Workout?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Workout?>, Workout?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Workout?>, Workout?>,
              AsyncValue<Workout?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
