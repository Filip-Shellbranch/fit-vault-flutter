import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_summary.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';
import 'package:isar_community/isar.dart';

class RunRepository {
  Isar db;
  RunRepository(this.db);

  Future<Run> saveRun(Run run, {bool isCompleted = false}) async {
    if (isCompleted) {
      run.endTime = DateTime.now();
    }
    RunModel newModel = RunModel.fromRun(run);
    if (isCompleted) {
      newModel.state = RunState.completed;
    }
    await db.writeTxn(() async {
      int id = await db.runModels.put(newModel);
      run.id = id;
    });
    return run;
  }

  Future<List<RunSummary>> loadRunSummaries() async {
    final models = await db.runModels.where().findAll();
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

    return run;
  }

  Future<List<Run>> getAllRuns() async {
    final models = await db.runModels.where().findAll();
    return models.map((model) => Run.fromModel(model)).toList();
  }
}
