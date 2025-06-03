

import 'package:flutter/material.dart';

class DarkBoxCard extends StatelessWidget {
  final Widget child;
  const DarkBoxCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xf7434040),
      ),
    );
  }
}
