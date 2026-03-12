import 'package:fit_vault_flutter/features/home_page/widgets/continue_activity_button.dart';
import 'package:fit_vault_flutter/features/home_page/widgets/new_activity_button.dart';
import 'package:fit_vault_flutter/features/home_page/widgets/title_widget.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final ActivityType currentActivity = ref.watch(currentActivityProvider);
        return Scaffold(
          appBar: AppBar(toolbarHeight: 20),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: currentActivity.isNone()
              ? NewActivityButton()
              : ContinueActivityButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TitleWidget(),
                ),
              ),
              SizedBox(height: 50),

              Expanded(child: Container()),
            ],
          ),
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }
}
