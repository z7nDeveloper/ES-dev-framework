

import 'package:flutter/material.dart';


// Made specifically for when you have a padding-less card with content on it

class TextExhibitionContainer extends StatelessWidget {
  final Widget child;
  const TextExhibitionContainer( {required this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16),
      child: child,
    );
  }
}
