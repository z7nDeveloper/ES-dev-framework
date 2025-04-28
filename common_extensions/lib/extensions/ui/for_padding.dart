import 'package:flutter/cupertino.dart';

extension PaddingExtension on EdgeInsets {
  multiply(EdgeInsets factor) {
    return EdgeInsets.only(
      top: top * factor.top,
      left: left * factor.left,
      right: right * factor.right,
      bottom: bottom * factor.bottom,
    );
  }
}
