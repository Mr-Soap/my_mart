import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const DrawListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          text,
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w600
          ),
          ),
        onTap: onTap,
      ),
    );
  }
}
