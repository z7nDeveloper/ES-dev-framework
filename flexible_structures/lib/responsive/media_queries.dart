import 'package:flexible_structures/responsive/size_restriction_definition/restrict_size_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// #todo : make a class for SizeWidthControl
// currently the getAppropriate functions dont update if the screen size changes,
// leading to unnecessary bugs that are weirdly solved by using
// MediaQuery.of(context).size.width (that automatically listens for changes for you)

enum DeviceType { desktop, mobile, tablet }

const RestrictedSizeModelOption baseWidthLimits =  RestrictedSizeModelOption(
    maxValue: 1024,
    minValue: 360
);
const RestrictedSizeModelOption expandedWidthLimits =  RestrictedSizeModelOption(
    maxValue: 1600,
    minValue: 360
);


const double MIN_HEIGHT = 640;

class DeviceOption<T> {
  T? desktop;
  T? mobile;
  T? defaultResult;
  T? tablet;

  DeviceOption({this.desktop, this.mobile, this.defaultResult, this.tablet});

  T getValue() {
    return returnAppropriateGlobal(
        defaultResult: defaultResult,
        desktop: desktop,
        mobile: mobile,
        tablet: tablet);
  }
}

DeviceType screenModelBasedOnWidth({context, double? width}) {
  //PlatformDispatcher.instance.views.first;
  width ??= context != null
      ? MediaQuery.of(context).size.width
      : MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

  final desktopSize = 1220;
  if (width >= desktopSize) {
    return DeviceType.desktop;
  }

  if (width >= 768) {
    return DeviceType.tablet;
  }

  return DeviceType.mobile;
}

T returnAppropriateGlobal<T>(
    {T? desktop, T? mobile, T? defaultResult, T? tablet}) {
  return returnFromModel(screenModelBasedOnWidth(),
      desktop: desktop,
      mobile: mobile,
      tablet: tablet,
      defaultResult: defaultResult);
}

T returnAppropriate<T>(BuildContext context,
    {T? desktop, T? mobile, T? tablet, T? defaultResult}) {
  DeviceType model = screenModelBasedOnWidth(context: context);
  return returnFromModel(model,
      desktop: desktop,
      mobile: mobile,
      tablet: tablet,
      defaultResult: defaultResult);
}

T returnFromModel<T>(DeviceType model,
    {T? desktop, T? mobile, T? tablet, T? defaultResult}) {
  defaultResult ??= (mobile ?? (tablet ?? desktop)) as T;

  switch (model) {
    case DeviceType.mobile:
      return mobile ?? defaultResult!;
    case DeviceType.desktop:
      return desktop ?? defaultResult!;
    case DeviceType.tablet:
      return tablet ?? defaultResult!;
  }
}

bool isMobile() {

  return screenModelBasedOnWidth() == DeviceType.mobile;
}

bool isMobileApp(BuildContext context) {
  return

    [
      TargetPlatform.iOS,
      TargetPlatform.android,

    ].contains(Theme.of(context).platform) ? true :
    screenModelBasedOnWidth() == DeviceType.mobile;
}

bool isLandscape() {
  return
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height < 500;

}

bool isTablet() {
  return screenModelBasedOnWidth() == DeviceType.tablet; 
}


bool isDesktop() {
  return screenModelBasedOnWidth() == DeviceType.desktop;
}

bool isDesktopApp(BuildContext context) {
  return
    [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS

    ].contains(Theme.of(context).platform) ? true :
    screenModelBasedOnWidth() == DeviceType.desktop

  ;
}
