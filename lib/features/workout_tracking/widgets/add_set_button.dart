import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_card.dart';
import 'package:flutter/material.dart';

class AddSetButton extends StatelessWidget {
  final AddSetCallback addSetFunc;
  const AddSetButton({super.key, required this.addSetFunc});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: addSetFunc,
      child: Row(children: [Text("Add new set")]),
    );
  }
}
