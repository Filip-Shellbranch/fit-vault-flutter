import 'package:fit_vault_flutter/features/workout_tracking/widgets/discard_workout_button.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/save_workout_button.dart';
import 'package:flutter/material.dart';

class FinishWorkoutButton extends StatefulWidget {
  const FinishWorkoutButton({super.key});

  @override
  State<FinishWorkoutButton> createState() => _FinishWorkoutButtonState();
}

class _FinishWorkoutButtonState extends State<FinishWorkoutButton> {
  bool _isOpen = false;

  void toggleOptions() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  Widget _buildAnimatedButton({required Widget button, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(
        milliseconds: 200 + (delay * 100),
      ), // Staggers the timing
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: button);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          onPressed: toggleOptions,
          heroTag: null,
          extendedPadding: EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            _isOpen ? Icons.close : Icons.check,
            size: 30,
            color: Colors.white,
          ),
          label: Text(
            _isOpen ? "Close" : "Finish workout",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        SizedBox(height: 16.0),
        if (_isOpen) ...[
          _buildAnimatedButton(button: SaveWorkoutButton(), delay: 1),
          const SizedBox(height: 16.0),
          _buildAnimatedButton(button: DiscardWorkoutButton(), delay: 0),
        ],
      ],
    );
  }
}
