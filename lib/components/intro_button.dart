import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;

  const IntroButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        height: 60,
        width: 120,    child: child,
      ),
    );
  }
}
