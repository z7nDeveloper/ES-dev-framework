import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flutter/cupertino.dart';


class FlexibleListing extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;

  final DeviceOption<Axis>? deviceAxis;
  final DeviceOption<bool>? inversion;
  final MainAxisSize? mainAxisSize;
  final EdgeInsets? elementPadding;
  final bool addPaddingAsSeparateWidget;

  final MainAxisAlignment? mainAxisAlignment;
  const FlexibleListing(
      {required this.children,
      this.deviceAxis,
      Key? key,
      this.crossAxisAlignment,
      this.inversion,
      this.mainAxisSize,
      this.mainAxisAlignment,
        this.addPaddingAsSeparateWidget=false,
      this.elementPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceOption<Axis> deviceAxisObject = deviceAxis ??
        DeviceOption(defaultResult: Axis.horizontal, mobile: Axis.vertical);

    List<Widget> widgets = children;

    if (inversion?.getValue() == true) {
      widgets = widgets.reversed.toList();
    }

    List<Widget> widgetChildren = [];

    if (elementPadding != null) {
      for (Widget widget in widgets) {

        if(addPaddingAsSeparateWidget) {
          widgetChildren.add(Padding(
            padding: elementPadding!,
          ));
          widgetChildren.add(widget);
          continue;
        }
        widgetChildren.add(Padding(
          padding: elementPadding!,
          child: widget,
        ));
      }
    } else {
      widgetChildren = widgets;
    }
    return Flex(
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      direction: deviceAxisObject.getValue(),
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: widgetChildren,
    );
  }
}
