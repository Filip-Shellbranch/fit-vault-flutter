import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunMapPage extends ConsumerStatefulWidget {
  const RunMapPage({super.key});

  @override
  ConsumerState<RunMapPage> createState() => _RunMapPageState();
}

class _RunMapPageState extends ConsumerState<RunMapPage> {
  late final MapController _controller;
  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RunningMap(controller: _controller, showCurrentPosition: true),
    );
  }
}
