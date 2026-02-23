import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/workout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return WorkoutRepository(isar);
});
