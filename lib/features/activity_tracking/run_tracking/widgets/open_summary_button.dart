import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_summary_page.dart';
import 'package:flutter/material.dart';

class OpenRunSummaryButton extends StatelessWidget {
  final Run run;
  const OpenRunSummaryButton({super.key, required this.run});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).highlightColor,
      label: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Open summary",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RunSummaryPage(run)),
        );
      },
    );
  }
}
