// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityList)
final activityListProvider = ActivityListProvider._();

final class ActivityListProvider
    extends $NotifierProvider<ActivityList, List<Activity>> {
  ActivityListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityListHash();

  @$internal
  @override
  ActivityList create() => ActivityList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Activity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Activity>>(value),
    );
  }
}

String _$activityListHash() => r'98e1a1a280af1d60af2b34492ddb736bd058e33b';

abstract class _$ActivityList extends $Notifier<List<Activity>> {
  List<Activity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Activity>, List<Activity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Activity>, List<Activity>>,
              List<Activity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
