import 'package:fit_vault_flutter/features/home_page/widgets/new_activity_button.dart';
import 'package:fit_vault_flutter/features/home_page/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 20),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: NewActivityButton(),
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
          Expanded(child: Container()),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
