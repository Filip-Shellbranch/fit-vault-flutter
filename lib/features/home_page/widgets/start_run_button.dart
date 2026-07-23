import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_session_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartRunButton extends ConsumerWidget {
  const StartRunButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await ActivityController(ref).startRun();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RunSessionPage()),
          );
        }
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
