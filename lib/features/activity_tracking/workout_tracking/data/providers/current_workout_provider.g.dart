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
    extends $NotifierProvider<CurrentWorkout, Workout> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Workout value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Workout>(value),
    );
  }
}

String _$currentWorkoutHash() => r'0d5cb7f3721ecbd4bbd196e30a0a93e731b22629';

abstract class _$CurrentWorkout extends $Notifier<Workout> {
  Workout build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Workout, Workout>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Workout, Workout>,
              Workout,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
