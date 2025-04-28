

import 'package:flexible_structures/widgets/display/background_card.dart';
import 'package:flutter/material.dart';

class SectionBackground extends StatelessWidget {
  final Widget child;
  const SectionBackground({Key? key,
  required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      child: child,

    );
  }
}
