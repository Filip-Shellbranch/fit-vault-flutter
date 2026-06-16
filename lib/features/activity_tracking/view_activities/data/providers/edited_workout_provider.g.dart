// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited_workout_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditedWorkout)
final editedWorkoutProvider = EditedWorkoutProvider._();

final class EditedWorkoutProvider
    extends $NotifierProvider<EditedWorkout, Workout> {
  EditedWorkoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editedWorkoutProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editedWorkoutHash();

  @$internal
  @override
  EditedWorkout create() => EditedWorkout();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Workout value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Workout>(value),
    );
  }
}

String _$editedWorkoutHash() => r'004eb4b679926b34363794f3a52526e408276dd3';

abstract class _$EditedWorkout extends $Notifier<Workout> {
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
