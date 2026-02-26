import 'package:fit_vault_flutter/core/database/isar_provider.dart';
import 'package:fit_vault_flutter/core/database/isar_service.dart';
import 'package:fit_vault_flutter/features/home_page/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarService.db)],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          highlightColor: Color(0xffdf7315),
          primaryColor: Color(0xff035fa1),
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
