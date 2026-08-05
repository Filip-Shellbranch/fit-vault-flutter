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
        RunPoint(1, 4, time, altitude: 5, type: PointType.pause),
        RunPoint(4, 24, time, altitude: 1, type: PointType.active),
        RunPoint(7, 224, time, altitude: 111, type: PointType.resume),
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

  group("test getting all runs", () {
    test("get all runs when there are none", () async {
      final runs = await repo.getAllRuns();
      expect(runs.isEmpty, true);
    });

    test("get all runs when there is one", () async {
      final run = Run(DateTime(1, 5, 3, 3));
      await repo.saveRun(run);
      final runs = await repo.getAllRuns();
      expect(runs.isEmpty, false);
      expect(runs.length, 1);
    });

    group("test data intact when saving and getting", () {
      test("single run data intact", () async {
        final DateTime time = DateTime(5, 3, 3, 5, 5);
        final run = Run(time);

        final points = [
          RunPoint(1, 4, time, altitude: 5, type: PointType.pause),
          RunPoint(4, 24, time, altitude: 1, type: PointType.end),
          RunPoint(7, 224, time, altitude: 111, type: PointType.resume),
        ];
        for (var point in points) {
          run.addPoint(point);
        }
        final savedRun = await repo.saveRun(run);
        final runs = await repo.getAllRuns();
        expect(runs.length, 1);

        final loadedRun = runs.first;

        expect(loadedRun.distance, run.distance);
        expect(loadedRun.positions.length, run.positions.length);
        expect(loadedRun.positions.length, points.length);
        expect(loadedRun.id, savedRun.id);
        expect(loadedRun.state, run.state);
        expect(loadedRun.startTime, run.startTime);

        for (var i = 0; i < points.length; i++) {
          final p1 = points[i];
          final p2 = loadedRun.positions[i];
          expect(p1.lat, p2.lat);
          expect(p1.lng, p2.lng);
          expect(p1.altitude, p2.altitude);
          expect(p1.type, p2.type);
        }
      });
    });
  });
}
