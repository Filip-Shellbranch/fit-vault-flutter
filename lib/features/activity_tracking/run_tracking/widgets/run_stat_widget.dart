import 'package:flutter/material.dart';

class RunStatWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  const RunStatWidget(this.title, this.value, {super.key, this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 20)),
              Text(
                unit != null ? " ($unit)" : "",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}
