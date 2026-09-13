import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_summary.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_point_model.dart';
import 'package:isar_community/isar.dart';
import 'package:rxdart/rxdart.dart';

class RunRepository {
  Isar db;
  RunRepository(this.db);

  Future<Run> saveRun(
    Run run, {
    bool isCompleted = false,
    bool onlyAddNewPoints = false,
  }) async {
    RunModel newModel = RunModel.fromRun(run);
    if (isCompleted) {
      newModel.state = RunState.completed;
    }
    await db.writeTxn(() async {
      int id = await db.runModels.put(newModel);
      run.id = id;

      final List<RunPointModel> pointModels;
      if (onlyAddNewPoints) {
        pointModels = run
            .getOnlyNewPoints()
            .map((point) => RunPointModel.fromRunPoint(point))
            .toList();
        run.clearNewPoints();
      } else {
        pointModels = run.positions
            .map((point) => RunPointModel.fromRunPoint(point))
            .toList();
      }

      await db.runPointModels.putAll(pointModels);
      newModel.points.addAll(pointModels);
      await newModel.points.save();
    });
    dInfo("Run saved!");
    return run;
  }

  Future<List<RunSummary>> loadRunSummaries() async {
    dPrint("Loading Run summaries");
    final models = await db.runModels.where().findAll();
    dPrint("Run summaries loaded");
    return models.map((model) => RunSummary.fromRunModel(model)).toList();
  }

  Future<Run?> loadRun(int id) async {
    final model = await db.runModels.get(id);
    if (model == null) {
      return null;
    }
    await model.points.load();

    final Run run = Run.fromModel(model);
    final List<RunPoint> points = model.points
        .map((pointModel) => RunPoint.fromModel(pointModel))
        .toList();
    run.positions.addAll(points);

    if (run.state == RunState.paused && run.positions.isNotEmpty) {
      run.pausedAt = run.positions.last.time;
    }
    dPrint("Run loaded");
    return run;
  }

  Future<List<Run>> getAllRuns() async {
    final models = await db.runModels.where().findAll();
    return models.map((model) => Run.fromModel(model)).toList();
  }

  Future<void> saveGpsPoint(RunPoint runPoint) async {}

  Future<Run?> getActiveRun() async {
    final RunModel? activeModel = await db.runModels
        .filter()
        .not()
        .stateEqualTo(RunState.completed)
        .findFirst();
    if (activeModel == null) {
      return null;
    }
    await activeModel.points.load();

    final Run run = Run.fromModel(activeModel);
    final List<RunPoint> points = activeModel.points
        .map((pointModel) => RunPoint.fromModel(pointModel))
        .toList();
    run.positions.addAll(points);

    if (run.state == RunState.paused && run.positions.isNotEmpty) {
      run.pausedAt = run.positions.last.time;
    }
    return run;
  }

  Stream<void> watchRunCompleted() {
    return db.runModels.filter().stateEqualTo(RunState.completed).watchLazy();
  }

  Stream<int?> watchRunCreated() {
    return db.runModels
        .filter()
        .stateEqualTo(RunState.notStarted)
        .distinctByState()
        .watch()
        .map((modelList) {
          return modelList.isEmpty ? null : modelList.first.id;
        })
        .distinct();
  }

  Stream<Run?> watchRun(int id) {
    // 1. Watch for changes to the parent RunModel
    final runStream = db.runModels.watchObjectLazy(id);

    // 2. Watch for changes to the linked points collection
    final pointsStream = db.runPointModels.watchLazy();

    // 3. Merge both streams and yield the fresh Run object on any trigger
    return Rx.merge([
      runStream,
      pointsStream,
    ]).asyncMap((_) => loadRun(id)); // Ensures an initial emission
  }

  Future<bool> deleteRun(int runId) async {
    return db.writeTxn(() async {
      final run = await db.runModels.get(runId);

      if (run == null) return false;

      await run.points.load();

      final pointIds = run.points.map((point) => point.id).toList();

      await db.runPointModels.deleteAll(pointIds);
      await db.runModels.delete(runId);

      return true;
    });
  }
}
