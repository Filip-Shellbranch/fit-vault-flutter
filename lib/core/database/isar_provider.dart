import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

/// Provides the created Isar instance throughout the app.
/// This value in the provider is overridden in main() once the database is fully opened.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError("Isar has not been intialized yet.");
});
