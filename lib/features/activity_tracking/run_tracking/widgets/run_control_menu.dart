import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunControlMenu extends ConsumerStatefulWidget {
  const RunControlMenu({super.key});

  @override
  ConsumerState<RunControlMenu> createState() => _RunControlMenuState();
}

class _RunControlMenuState extends ConsumerState<RunControlMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

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
  }
}
