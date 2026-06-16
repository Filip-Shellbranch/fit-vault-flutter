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

String _$editedWorkoutHash() => r'3f5e11662e907e27f68c0cac167c0584498cbf94';

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
