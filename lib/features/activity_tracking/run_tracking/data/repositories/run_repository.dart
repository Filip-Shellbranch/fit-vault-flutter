import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';
import 'package:isar_community/isar.dart';

class RunRepository {
  Isar db;
  RunRepository(this.db);

  Future<Run> saveRun(Run run, {bool isCompleted = false}) async {
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

  Future<List<Run>> getAllRuns() async {
    final models = await db.runModels.where().findAll();
    return models.map((model) => Run.fromModel(model)).toList();
  }
}
