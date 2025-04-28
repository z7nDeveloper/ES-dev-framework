import 'package:common_extensions/extensions/ui/for_colors.dart';
import 'package:flutter/material.dart';


class RandomColorListWidget extends StatelessWidget {
  final List<Widget?> children;
  final Widget Function(Widget child, int index)? childrenParentList;
  final bool enabled;
  final Widget Function(List<Widget> children) parentBuilder;
  const RandomColorListWidget({super.key, required this.children,
    this.enabled=true,
    this.childrenParentList,
    required this.parentBuilder});

  @override
  Widget build(BuildContext context) {


    List<Widget> widgetChildren = [];


    for(int i = 0; i < children.length; ++i) {


      Widget widget = children[i] ?? Container();

      if(enabled) {
        widget =
            Container(
                color: ColorExtension.random(),
                child: widget);
      }

      if(childrenParentList != null) {

        widget = childrenParentList!(widget, i);

      }

      widgetChildren.add(widget);
    }

    return parentBuilder(widgetChildren);
  }
}
