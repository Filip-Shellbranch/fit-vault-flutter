// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_pace_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentPace)
final currentPaceProvider = CurrentPaceProvider._();

final class CurrentPaceProvider extends $NotifierProvider<CurrentPace, Pace> {
  CurrentPaceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPaceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPaceHash();

  @$internal
  @override
  CurrentPace create() => CurrentPace();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Pace value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Pace>(value),
    );
  }
}

String _$currentPaceHash() => r'3883539a446be210f1d0029f11e7a108838050ca';

abstract class _$CurrentPace extends $Notifier<Pace> {
  Pace build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Pace, Pace>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Pace, Pace>,
              Pace,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
