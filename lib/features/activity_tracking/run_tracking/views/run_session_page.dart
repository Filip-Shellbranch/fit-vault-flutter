import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_control_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/run_map_page.dart';
import 'package:flutter/material.dart';

class RunSessionPage extends StatefulWidget {
  const RunSessionPage({super.key});

  @override
  State<RunSessionPage> createState() => _RunSessionPageState();
}

class _RunSessionPageState extends State<RunSessionPage>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _tabController;
  final int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [RunMapPage(), RunControlPage()],
    );
  }
}
