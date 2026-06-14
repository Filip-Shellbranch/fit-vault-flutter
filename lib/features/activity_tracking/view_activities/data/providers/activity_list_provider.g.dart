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
    extends $AsyncNotifierProvider<ActivityList, List<Activity>> {
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
}

String _$activityListHash() => r'45ea85b9489e3f6243550b742673d28e75143557';

abstract class _$ActivityList extends $AsyncNotifier<List<Activity>> {
  FutureOr<List<Activity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Activity>>, List<Activity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Activity>>, List<Activity>>,
              AsyncValue<List<Activity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
