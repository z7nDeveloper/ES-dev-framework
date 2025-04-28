

import 'package:flutter/material.dart';

/// A list column that maps its [children] to the associated [flex]
class ExpandedWidgetVector extends StatelessWidget {

  final List<Widget?> children;
  final List<int?> flex;
  const ExpandedWidgetVector({super.key,
  required this.children,
    required this.flex,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i = 0; i < children.length; i++)
          Expanded(
            flex: flex[i] ?? 0 ,
            child: children[i] ?? Container(),
          ),
      ],
    );
  }
}
