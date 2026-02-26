import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FitVault",
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Your workouts,\n",
                style: TextStyle(color: Theme.of(context).highlightColor),
              ),
              TextSpan(
                text: 'your data.',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
