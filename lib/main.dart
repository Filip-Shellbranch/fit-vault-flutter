import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/core/database/isar_service.dart';
import 'package:fit_vault_flutter/features/home_page/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.init();

  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarService.db)],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: HomePage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
