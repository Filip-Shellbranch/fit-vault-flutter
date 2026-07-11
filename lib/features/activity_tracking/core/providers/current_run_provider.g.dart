// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_run_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentRun)
final currentRunProvider = CurrentRunProvider._();

final class CurrentRunProvider
    extends $AsyncNotifierProvider<CurrentRun, Run?> {
  CurrentRunProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentRunProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentRunHash();

  @$internal
  @override
  CurrentRun create() => CurrentRun();
}

String _$currentRunHash() => r'333a8e9702283b78b5a9b2cd311b6dd8594a44a6';

abstract class _$CurrentRun extends $AsyncNotifier<Run?> {
  FutureOr<Run?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Run?>, Run?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Run?>, Run?>,
              AsyncValue<Run?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
