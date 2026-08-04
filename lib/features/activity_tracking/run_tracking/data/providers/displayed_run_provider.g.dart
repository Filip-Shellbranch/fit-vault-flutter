// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'displayed_run_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DisplayedRun)
final displayedRunProvider = DisplayedRunProvider._();

final class DisplayedRunProvider extends $NotifierProvider<DisplayedRun, Run?> {
  DisplayedRunProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayedRunProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayedRunHash();

  @$internal
  @override
  DisplayedRun create() => DisplayedRun();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Run? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Run?>(value),
    );
  }
}

String _$displayedRunHash() => r'83fcaa1ef3d01f4da67081d01b751001f0b18744';

abstract class _$DisplayedRun extends $Notifier<Run?> {
  Run? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Run?, Run?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Run?, Run?>,
              Run?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
