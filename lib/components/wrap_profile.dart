
import 'package:clan_churn/components/profile.dart';
import 'package:flutter/material.dart';

class WrapProfile extends StatelessWidget {
  const WrapProfile({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Positioned(right: 0, top: 15, child:   ProfileWidget()),
      ],
    );
  }
}