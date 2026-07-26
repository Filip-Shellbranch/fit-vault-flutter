import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewRunPage extends ConsumerStatefulWidget {
  final Run run;
  const ViewRunPage({super.key, required this.run});

  @override
  ConsumerState<ViewRunPage> createState() => _RunMapPageState();
}

class _RunMapPageState extends ConsumerState<ViewRunPage> {
  late final MapController _controller;
  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Run on: ${formatDate(widget.run.startTime)}"),
      ),
      body: RunningMap(controller: _controller, targetRun: widget.run),
    );
  }
}
