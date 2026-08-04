// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationPermission)
final locationPermissionProvider = LocationPermissionProvider._();

final class LocationPermissionProvider
    extends $AsyncNotifierProvider<LocationPermission, LocationRequestResult> {
  LocationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionHash();

  @$internal
  @override
  LocationPermission create() => LocationPermission();
}

String _$locationPermissionHash() =>
    r'fc1f311723907ac8103aa45ecfc4bb407d0d0b1c';

abstract class _$LocationPermission
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
