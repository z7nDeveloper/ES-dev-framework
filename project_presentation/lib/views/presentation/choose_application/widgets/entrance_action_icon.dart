

import 'package:flutter/material.dart';


class EntranceActionIconConfiguration  {

  final double iconSize;
  final double scale;

  EntranceActionIconConfiguration({
    required this.iconSize,
    required this.scale,
});
}

class EntranceActionIcon extends StatelessWidget {
  final Widget child;
  final EntranceActionIconConfiguration configuration;
  const EntranceActionIcon({super.key, required this.child, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: configuration.scale,
      child: Container(
          width: configuration.iconSize,
          child: child)
    );
  }
}
