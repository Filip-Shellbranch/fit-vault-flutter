import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_details.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_map.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_run_provider.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ref.read(editedRunProvider.notifier).stopEdit();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Run on: ${formatDate(widget.run.startTime)}"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              RunningMap(controller: _controller),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [RunDetails(run: widget.run)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
