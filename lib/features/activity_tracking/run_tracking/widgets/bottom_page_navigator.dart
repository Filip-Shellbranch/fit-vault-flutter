import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final int index;
  final int currentPage;
  final VoidCallback onPressed;
  const NavigationButton({
    super.key,
    required this.index,
    required this.currentPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: index == currentPage
              ? Theme.of(context).highlightColor
              : Colors.grey,
        ),
      ),
    );
  }
}

class BottomPageNavigator extends StatelessWidget {
  final PageController controller;
  final int numPages;
  final int currentPage;
  const BottomPageNavigator({
    super.key,
    required this.controller,
    required this.numPages,
    required this.currentPage,
  });

  void _navigateToPage(int index) {
    controller.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  NavigationButton _createButton(int index) {
    return NavigationButton(
      index: index,
      currentPage: currentPage,
      onPressed: () {
        _navigateToPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationButton> buttons = [];
    for (var i = 0; i < numPages; i++) {
      buttons.add(_createButton(i));
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons,
      ),
    );
  }
}
