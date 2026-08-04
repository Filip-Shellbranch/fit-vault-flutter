import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/repositories/exercise_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return ExerciseRepository(isar);
});
