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
    extends $AsyncNotifierProvider<ActivityList, List<GroupedActivity>> {
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

String _$activityListHash() => r'b84f47053c7eed68a6e7899bfcea6136144fbceb';

abstract class _$ActivityList extends $AsyncNotifier<List<GroupedActivity>> {
  FutureOr<List<GroupedActivity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<GroupedActivity>>, List<GroupedActivity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<GroupedActivity>>,
                List<GroupedActivity>
              >,
              AsyncValue<List<GroupedActivity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
