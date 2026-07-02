import 'package:flutter/material.dart';

class HomePageMenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget targetPage;
  final Widget? subWidget;
  const HomePageMenuButton({
    super.key,
    required this.icon,
    required this.title,
    required this.targetPage,
    this.subWidget,
  });

  @override
  Widget build(BuildContext context) {
    final Color fgColor = Colors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
        ),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => targetPage),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: fgColor, size: 30),
                    Text(title, style: TextStyle(color: fgColor, fontSize: 22)),
                  ],
                ),
              ),
            ),
            subWidget ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
