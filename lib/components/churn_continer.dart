import 'package:flutter/material.dart';

class ChurnContainer extends StatelessWidget {
  const ChurnContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      // height: h * 0.82,
      // width: widget.width,
      // height: MediaQuery.of(context).size.height * 0.83,
      // width: width,
      margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}
