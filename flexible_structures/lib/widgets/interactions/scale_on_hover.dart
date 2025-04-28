import 'package:flexible_structures/widgets/interactions/on_hover_element.dart';
import 'package:flutter/material.dart';

class ScaleOnHover extends StatelessWidget {
  final Widget child;
  final Matrix4? hovered;
  final Matrix4? notHovered;

  const ScaleOnHover({
    Key? key,
    required this.child,
    this.hovered,
    this.notHovered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnHover(builder: (isHovered) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? (hovered ?? Matrix4.diagonal3Values(1.01, 1.01, 1))
            : (notHovered ?? Matrix4.diagonal3Values(1.0, 1.0, 1)),
        child: child,
      );
    });
  }
}
