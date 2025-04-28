


import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flutter/material.dart';

class ScreenPanel extends StatelessWidget {
  final double? height;
  final Widget? child;
  final int? flex;
  const ScreenPanel({super.key,
    this.child,
    this.flex,
    this.height,});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: flex ?? 1,
      child: Container(
      decoration: BoxDecoration(

          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
      ),
      height: height ?? context.height*0.9,
      child: child,
    ),);
  }
}
