import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/repositories/exercise_type_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseTypeRepositoryProvider = Provider<ExerciseTypeRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return ExerciseTypeRepository(isar);
});
