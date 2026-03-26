import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/saved_exercise_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savedExerciseRepositoryProvider = Provider<SavedExerciseRepository>((
  ref,
) {
  final isar = ref.watch(isarProvider);
  return SavedExerciseRepository(isar);
});
