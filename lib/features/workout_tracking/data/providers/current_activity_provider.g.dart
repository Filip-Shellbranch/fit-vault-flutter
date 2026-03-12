// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentActivity)
final currentActivityProvider = CurrentActivityProvider._();

final class CurrentActivityProvider
    extends $NotifierProvider<CurrentActivity, ActivityType> {
  CurrentActivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentActivityHash();

  @$internal
  @override
  CurrentActivity create() => CurrentActivity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivityType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivityType>(value),
    );
  }
}

String _$currentActivityHash() => r'047a946a1c68a5afef60a461649ba0c3c1dafec6';

abstract class _$CurrentActivity extends $Notifier<ActivityType> {
  ActivityType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ActivityType, ActivityType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActivityType, ActivityType>,
              ActivityType,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
