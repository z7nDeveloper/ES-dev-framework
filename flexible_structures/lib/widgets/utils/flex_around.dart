



import 'package:flexible_structures/widgets/utils/flexible_if_not_null.dart';
import 'package:flutter/cupertino.dart';
class FlexAround extends StatelessWidget {

  final EdgeInsets directions;
  final Widget child;
  final int? flexSelf;
  const FlexAround({super.key, required this.directions, required this.child,
  this.flexSelf,});

  @override
  Widget build(BuildContext context) {

    Widget buildChild = child;

    if(flexSelf != null) {
      buildChild = Expanded(child: child,
      flex: flexSelf!,);
    }

    if(directions.left != 0 || directions.right != 0) {
      buildChild = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NullSafeFlexible(flex: directions.left.toInt(), child: null, useSpaceWhenEmpty: true,),
          child,
          NullSafeFlexible(flex: directions.right.toInt(), child: null, useSpaceWhenEmpty: true,),

        ],
      );
    }
    if(directions.top != 0 || directions.bottom != 0) {
      buildChild = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NullSafeFlexible(flex: directions.top.toInt(), child: null, useSpaceWhenEmpty: true,),
          child,
          NullSafeFlexible(flex: directions.bottom.toInt(), child: null, useSpaceWhenEmpty: true,),

        ],
      );
    }

    return buildChild;
  }
}
