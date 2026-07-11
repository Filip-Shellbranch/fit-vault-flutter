// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationPermissionProvider)
final locationPermissionProviderProvider =
    LocationPermissionProviderProvider._();

final class LocationPermissionProviderProvider
    extends
        $AsyncNotifierProvider<
          LocationPermissionProvider,
          LocationRequestResult
        > {
  LocationPermissionProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionProviderHash();

  @$internal
  @override
  LocationPermissionProvider create() => LocationPermissionProvider();
}

String _$locationPermissionProviderHash() =>
    r'0a4ebc1f90d4ed1fecc9556dd973c5a66b259835';

abstract class _$LocationPermissionProvider
    extends $AsyncNotifier<LocationRequestResult> {
  FutureOr<LocationRequestResult> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<LocationRequestResult>, LocationRequestResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LocationRequestResult>,
                LocationRequestResult
              >,
              AsyncValue<LocationRequestResult>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
