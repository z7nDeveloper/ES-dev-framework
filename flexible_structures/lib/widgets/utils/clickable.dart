

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Clickable extends StatefulWidget {
  final Widget child;
  final Function()? onPress;
  final bool canPress;
  final Color? colorOnHover;
  const Clickable({super.key,
  required this.child,
    this.canPress=true,
    this.colorOnHover,
    required this.onPress,
  });

  @override
  State<Clickable> createState() => _ClickableState();
}

class _ClickableState extends State<Clickable> {

  Color? hoverColor;
  @override
  Widget build(BuildContext context) {

    if(!widget.canPress) {
      return widget.child;
    }

    Widget child =widget.child;

    if(widget.colorOnHover != null) {

      child = AnimatedContainer(
          curve: Curves.bounceInOut,
          color: hoverColor,
          duration: Duration(seconds: 5),
          child: child);
    }

    return  MouseRegion(
      cursor:
      widget.onPress == null ?  SystemMouseCursors.basic :
      SystemMouseCursors.click,
      onEnter:
          widget.colorOnHover == null ? null :
          (_) {
        setState(() {
          hoverColor = widget.colorOnHover;
        });
      },
      onExit: widget.colorOnHover == null ? null : (_) {
        setState(() {
          hoverColor = null;
        });
      },
      child: GestureDetector( 

          onTap: widget.onPress,
          child: child

      ),
    );
  } 
}
