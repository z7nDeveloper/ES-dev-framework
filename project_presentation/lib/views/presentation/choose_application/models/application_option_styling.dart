


import 'package:flutter/material.dart';

import 'application_option.dart';

class ApplicationOptionStyling {
  final Widget Function(ApplicationOption option) getIcon;

  final Widget Function(ApplicationOption option)? getBackIcon;

  ApplicationOptionStyling({
    required this.getIcon,
    this.getBackIcon,
  });
}