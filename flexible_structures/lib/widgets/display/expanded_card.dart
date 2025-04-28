





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExpandedCardStyle {

  final EdgeInsets? padding;

  ExpandedCardStyle({
    required this.padding,
});
}

class ExpandedCard extends StatelessWidget {
  final Widget child;
  final ExpandedCardStyle? cardStyle;
  final double multiply;
  const ExpandedCard({super.key, required this.child,
      this.cardStyle,
    this.multiply=1,

  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: (2 * multiply).toInt(),
        child: Padding(
          padding: cardStyle?.padding ?? EdgeInsets.zero,
          child: Container(

              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xfff4f4f4)
              ),
              child: child),
        ));
  }
}
