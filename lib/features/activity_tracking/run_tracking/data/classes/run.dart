import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';

class Run {
  int? id;
  final DateTime startTime;

  final List<RunPoint> positions = [];

  Run(this.startTime);
}
