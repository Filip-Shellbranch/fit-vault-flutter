import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/gps_strength_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeginRunButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const BeginRunButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(gpsStrengthProvider).isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return TextButton(
      onPressed: onPressed,
      style:
          TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          ).copyWith(
            overlayColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: 0.15),
            ),
          ),
      child: const Text(
        "Start",
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}

class RunControlMenu extends ConsumerStatefulWidget {
  const RunControlMenu({super.key});

  @override
  ConsumerState<RunControlMenu> createState() => _RunControlMenuState();
}

class _RunControlMenuState extends ConsumerState<RunControlMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  void onStartPressed() {
    ref.read(currentRunProvider.notifier).beginRun();
  }

  void onPausePressed() {
    ref.read(currentRunProvider.notifier).pauseRun();
    controller.forward();
  }

  void onResumePressed() async {
    ref.read(currentRunProvider.notifier).resumeRun();
    controller.reverse();
  }

  void onFinishPressed() async {
    await ref.read(currentRunProvider.notifier).stopRun();
    ActivityController(ref).stop();
    if (mounted) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  Widget build(BuildContext context) {
    final runAsync = ref.watch(currentRunProvider);
    return runAsync.maybeWhen(
      data: (run) {
        if (run == null) {
          return Text("No run active.");
        }

        if (!run.isStarted()) {
          return BeginRunButton(onStartPressed);
        }

        if (run.isPaused()) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(1, 0.0),
                    ).animate(controller),
                    child: Opacity(
                      opacity: controller.value,
                      child: RunControlButton(
                        icon: Icons.stop,
                        onPressed: onFinishPressed,
                        buttonColor: Colors.red.shade800,
                      ),
                    ),
                  ),

                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(-1, 0.0),
                    ).animate(controller),
                    child: Opacity(
                      opacity: controller.value,
                      child: RunControlButton(
                        icon: Icons.play_arrow,
                        onPressed: onResumePressed,
                      ),
                    ),
                  ),

                  Visibility(
                    visible: controller.value < 1,
                    child: Transform.scale(
                      scale: 1 - controller.value,
                      child: Opacity(
                        opacity: 1 - controller.value,
                        child: RunControlButton(
                          icon: Icons.pause,
                          onPressed: onPausePressed,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      orElse: () {
        return Text("Unable to get current run.");
      },
    );
  }
}
