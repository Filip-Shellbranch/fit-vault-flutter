import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return RunRepository(isar);
});
