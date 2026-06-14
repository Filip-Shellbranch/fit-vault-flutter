import 'package:flutter/material.dart';

class ViewActivitesPage extends StatefulWidget {
  const ViewActivitesPage({super.key});

  @override
  State<ViewActivitesPage> createState() => _ViewActivitesPageState();
}

class _ViewActivitesPageState extends State<ViewActivitesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Back"), foregroundColor: Colors.white),
      body: Column(),
    );
  }
}
