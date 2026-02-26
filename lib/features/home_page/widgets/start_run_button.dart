import 'package:flutter/material.dart';

class StartRunButton extends StatelessWidget {
  const StartRunButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Run tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(infoMessage);
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
