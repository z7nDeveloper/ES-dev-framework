


import 'package:flutter/cupertino.dart';

class SpaceContained extends StatelessWidget {
  final double totalHeight;
  final double spacing;
  final Widget child;
  const SpaceContained({super.key,
  required this.totalHeight,
    required this.child,
  required this.spacing,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Container(
        height:  totalHeight - 2 * spacing,
        child: child,
      ),
    );
  }
}
