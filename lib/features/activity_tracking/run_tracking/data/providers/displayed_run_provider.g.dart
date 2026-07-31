// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'displayed_run_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(displayedRun)
final displayedRunProvider = DisplayedRunProvider._();

final class DisplayedRunProvider extends $FunctionalProvider<Run?, Run?, Run?>
    with $Provider<Run?> {
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
  $ProviderElement<Run?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Run? create(Ref ref) {
    return displayedRun(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Run? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Run?>(value),
    );
  }
}

String _$displayedRunHash() => r'e46419c1d9c048e5387259eb1f90c053f09b3057';
