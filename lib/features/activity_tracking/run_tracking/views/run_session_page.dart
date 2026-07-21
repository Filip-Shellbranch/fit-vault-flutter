import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_control_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_map_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/bottom_page_navigator.dart';
import 'package:flutter/material.dart';

class RunSessionPage extends StatefulWidget {
  const RunSessionPage({super.key});

  @override
  State<RunSessionPage> createState() => _RunSessionPageState();
}

class _RunSessionPageState extends State<RunSessionPage>
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
    return Stack(
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
    );
  }
}
