import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_card.dart';
import 'package:flutter/material.dart';

class SetCard extends StatelessWidget {
  final int index;
  final ExerciseSet set;
  final UpdateSetCallback updateSetFunc;
  const SetCard({
    super.key,
    required this.index,
    required this.set,
    required this.updateSetFunc,
  });

  void onRepsChanged(String newValueString) {
    int newValue = int.parse(newValueString);
    if (newValue == set.reps) {
      // No change
      return;
    }

    updateSetFunc(index, newValue, set.weight);
    debugPrint("Reps changed");
  }

  void onWeightChanged(String newValueString) {
    double newValue = double.parse(newValueString);
    if (newValue == set.weight) {
      // No change
      return;
    }
    updateSetFunc(index, set.reps, newValue);
    debugPrint("Weight changed");
  }

  @override
  Widget build(BuildContext context) {
    final repsController = TextEditingController(text: set.reps.toString());
    final weightController = TextEditingController(
      text: set.weight.toStringAsFixed(1),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).primaryColor, width: 6.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Set ${index + 1}"),
          Row(
            spacing: 8,
            children: [
              Container(
                width: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                child: TextField(
                  onSubmitted: onRepsChanged,
                  controller: repsController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Text("reps", style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Container(
                width: 80,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Theme.of(context).highlightColor),
                  ),
                ),
                child: TextField(
                  onSubmitted: onWeightChanged,
                  controller: weightController,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Text("kg", style: TextStyle(fontSize: 16)),
            ],
          ),
          IconButton(
            onPressed: () {
              // TODO: Remove set
            },
            icon: Icon(Icons.remove, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
