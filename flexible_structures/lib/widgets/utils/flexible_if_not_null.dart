



import 'package:flutter/cupertino.dart';

class NullSafeFlexible extends StatelessWidget {
  final Widget? child;
  final int flex;
  final bool useSpaceWhenEmpty;
  final Widget Function(Widget)? parent;
  final bool useExpanded;
  final Color? color;

  const NullSafeFlexible({super.key, this.child, required this.flex,
  this.useSpaceWhenEmpty=false,
    this.useExpanded=true,
    this.color,
  this.parent,});

  @override
  Widget build(BuildContext context) {
    if(child == null) {
      if(!useSpaceWhenEmpty) {
        return Container();
      }
    }

    Widget widget = (parent == null) ?
    (child ?? Container()) : (parent!(child ?? Container()));

    widget = Container(
      child: widget,
      color:color,
    );

    return useExpanded ? Expanded(child:widget, flex: flex,) : Flexible(
      child: widget, flex: flex,
    );
  }
}
