

import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class WhiteBoxAnimatedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const WhiteBoxAnimatedContainer({super.key, required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color:
         GetIt.I.get<FlexibleThemeColors>().getCardColor(),
        //Colors.grey.shade100, //Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: child,
    );
  }
}
