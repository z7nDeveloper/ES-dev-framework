
import 'package:flexible_structures/widgets/interactions/on_hover_element.dart';
import 'package:flutter/material.dart';

class OpacityOnHover extends StatelessWidget {
  final Widget child;
  const OpacityOnHover({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnHover(builder: (isHovered) {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: isHovered ? 1 : 0.15,
        child: child,
      );
    });
  }
}
