import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;

  const MoreButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF9D00),
              Color(0xFFF5C857),
            ]
          ),
        ),
        height: 35,
        width: 150,
        child: child,
      ),
    );
  }
}