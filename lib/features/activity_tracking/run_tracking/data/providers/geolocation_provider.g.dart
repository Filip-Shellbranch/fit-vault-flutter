// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geoLocationRepository)
final geoLocationRepositoryProvider = GeoLocationRepositoryProvider._();

final class GeoLocationRepositoryProvider
    extends
        $FunctionalProvider<
          GeoLocationRepository,
          GeoLocationRepository,
          GeoLocationRepository
        >
    with $Provider<GeoLocationRepository> {
  GeoLocationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geoLocationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geoLocationRepositoryHash();

  @$internal
  @override
  $ProviderElement<GeoLocationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeoLocationRepository create(Ref ref) {
    return geoLocationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeoLocationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeoLocationRepository>(value),
    );
  }
}

String _$geoLocationRepositoryHash() =>
    r'b206d2c436c9820b20fbd3b1e381ce363d82174f';
