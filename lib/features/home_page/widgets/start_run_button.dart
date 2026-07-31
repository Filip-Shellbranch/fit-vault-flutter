import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_session_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartRunButton extends ConsumerWidget {
  const StartRunButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RunSessionPage()),
        );

        ref.read(activityControllerProvider).startRun();
      },
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      icon: ImageIcon(AssetImage("assets/icons/icons8-running-100.png")),
      label: SizedBox(
        width: 200,
        child: Text("Start run", style: TextStyle(fontSize: 26)),
      ),
    );
  }
}
