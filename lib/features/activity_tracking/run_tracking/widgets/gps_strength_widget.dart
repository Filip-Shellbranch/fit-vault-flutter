import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/gps_strength_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GpsBar extends StatelessWidget {
  final double heightFactor;
  final Color barColor;
  const GpsBar({super.key, required this.heightFactor, required this.barColor});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Container(color: barColor, width: 5),
    );
  }
}

class GpsStrengthWidget extends ConsumerWidget {
  const GpsStrengthWidget({super.key});

  final Color emptyBarColor = Colors.black;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strengthAsync = ref.watch(gpsStrengthProvider);
    return strengthAsync.when(
      data: (gpsStrength) {
        final strength = gpsStrength.strength;
        final barColor = strength == GpsSignalStrength.strong
            ? Colors.green
            : strength == GpsSignalStrength.medium
            ? Colors.amber
            : Colors.red;
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(Icons.gps_fixed_rounded),
                Text("GPS"),
                SizedBox(height: 6),
                SizedBox(
                  height: 24,
                  width: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GpsBar(heightFactor: 1 / 3, barColor: barColor),
                      GpsBar(
                        heightFactor: 2 / 3,
                        barColor:
                            strength.index >= GpsSignalStrength.medium.index
                            ? barColor
                            : emptyBarColor,
                      ),
                      GpsBar(
                        heightFactor: 3 / 3,
                        barColor:
                            strength.index >= GpsSignalStrength.strong.index
                            ? barColor
                            : emptyBarColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, trace) {
        return Text(e.toString());
      },
      loading: () {
        return Text("Loading");
      },
    );
  }
}
