import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_control_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_map_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/bottom_page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunSessionPage extends ConsumerStatefulWidget {
  const RunSessionPage({super.key});

  @override
  ConsumerState<RunSessionPage> createState() => _RunSessionPageState();
}

class _RunSessionPageState extends ConsumerState<RunSessionPage>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPageIndex = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [RunMapPage(), RunControlPage()];
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          final run = ref.read(currentRunProvider).value;
          if (run == null || !run.isStarted()) {
            ref.read(activityControllerProvider).stop();
          }
        }
      },
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: pages,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: BottomPageNavigator(
                    controller: _pageController,
                    numPages: pages.length,
                    currentPage: _currentPageIndex,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
