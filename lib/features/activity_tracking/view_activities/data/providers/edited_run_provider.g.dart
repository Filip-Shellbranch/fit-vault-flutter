// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edited_run_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditedRun)
final editedRunProvider = EditedRunProvider._();

final class EditedRunProvider extends $NotifierProvider<EditedRun, Run?> {
  EditedRunProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editedRunProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editedRunHash();

  @$internal
  @override
  EditedRun create() => EditedRun();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Run? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Run?>(value),
    );
  }
}

String _$editedRunHash() => r'11e4336a573ad541ee989ac7b82e504fec946fdc';

abstract class _$EditedRun extends $Notifier<Run?> {
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
