import 'package:flutter/material.dart';

class StartWorkoutButton extends StatelessWidget {
  const StartWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
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
      icon: ImageIcon(AssetImage("assets/icons/icons8-gym-100.png")),
      label: SizedBox(
        width: 200,
        child: Text("Start workout", style: TextStyle(fontSize: 26)),
      ),
    );
  }
}
