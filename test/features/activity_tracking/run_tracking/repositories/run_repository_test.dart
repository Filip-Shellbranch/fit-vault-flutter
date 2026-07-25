import 'dart:io';

import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late RunRepository repo;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      RunModelSchema,
    ], directory: Directory.systemTemp.path);
    repo = RunRepository(isar);
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  group("test saving runs", () {
    test("save a single empty run without id", () async {
      DateTime time = DateTime(1, 2);
      final run = Run(time);
      await expectLater(await isar.runModels.count(), 0);
      final savedRun = await repo.saveRun(run);
      expect(savedRun.distance, run.distance);
      expect(savedRun.positions.isEmpty, run.positions.isEmpty);
      expect(savedRun.id, isNotNull);
      expect(savedRun.id, 1);
      expect(savedRun.state, run.state);
      expect(savedRun.startTime, run.startTime);
      await expectLater(await isar.runModels.count(), 1);
    });

    test("save a single run with several points", () async {
      DateTime time = DateTime(1, 2);
      final run = Run(time);

      final points = [
        RunPoint(1, 4, altitude: 5, type: PointType.pause),
        RunPoint(4, 24, altitude: 1, type: PointType.active),
        RunPoint(7, 224, altitude: 111, type: PointType.resume),
      ];
      for (var point in points) {
        run.addPoint(point);
      }
      await expectLater(await isar.runModels.count(), 0);
      final savedRun = await repo.saveRun(run);
      expect(savedRun.distance, run.distance);
      expect(savedRun.positions.length, run.positions.length);
      expect(savedRun.positions.length, points.length);
      expect(savedRun.id, isNotNull);
      expect(savedRun.id, 1);
      expect(savedRun.state, run.state);
      expect(savedRun.startTime, run.startTime);
      for (var i = 0; i < points.length; i++) {
        final p1 = points.elementAt(i);
        final p2 = savedRun.positions.elementAt(i);
        expect(p1.lat, p2.lat);
        expect(p1.lng, p2.lng);
        expect(p1.altitude, p2.altitude);
        expect(p1.type, p2.type);
      }
      await expectLater(await isar.runModels.count(), 1);
    });
  });
}
