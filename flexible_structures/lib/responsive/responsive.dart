import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {Key? key,
      this.desktop,
      this.tablet,
      this.mobile,
      this.defaultWidget,
      this.forceDefault = false})
      : super(key: key);

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;
  final Widget? defaultWidget;
  final bool forceDefault;

  @override
  Widget build(BuildContext context) {
    if (forceDefault) {
      return defaultWidget!;
    }

    MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      DeviceType model = screenModelBasedOnWidth();

      switch (model) {
        case DeviceType.desktop:
          return desktop ?? defaultWidget ?? Container();
        case DeviceType.mobile:
          return mobile ?? defaultWidget ?? Container();
        case DeviceType.tablet:
          return tablet ?? defaultWidget ?? Container();
      }
    });
  }
}
