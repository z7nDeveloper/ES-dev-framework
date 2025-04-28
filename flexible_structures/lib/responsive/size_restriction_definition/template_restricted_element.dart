import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateRestrictedElement extends StatelessWidget
    implements PreferredSizeWidget {
  final double realWidth;
  final double restrictedWidth;
  final Widget? background;
  final Widget? content;
  final dynamic preferredHeight;
  final double? restrictedHeight;

  final Widget Function(BuildContext context, double realWidth, Widget body)?
      parentBody;

  const TemplateRestrictedElement(
      {required this.realWidth,
      required this.restrictedWidth,
      this.background,
      this.content,
      this.parentBody,
      this.preferredHeight,
      super.key,
      this.restrictedHeight});

  @override
  Widget build(BuildContext context) {
    List<Widget> layers = [];

    if (background != null) {
      layers.add(background!);
    }

    if (content != null) {
      Widget body = MediaQuery(
          data: MediaQuery.of(context).copyWith(
              size: Size(restrictedWidth,
                  restrictedHeight ?? MediaQuery.of(context).size.height)),
          child: Container(
              width: restrictedWidth,
              child: Container(

                  //color: Colors.blue,
                  child: content)));

      if (parentBody != null) {
        body = parentBody!(context, realWidth, body);
      }

      layers.add(Center(
        child: body,
      ));
    }

    return Container(
      width: realWidth,
      child: Stack(children: layers),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight is int ? preferredHeight.toDouble() : (preferredHeight ?? 60));
}
