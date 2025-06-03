

import 'package:flutter/material.dart';


abstract class ReactiveInputTheme {
  InputDecoration decoration(String label);
}


class BaseReactiveInputTheme extends ReactiveInputTheme {
  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.only(bottom: 8, left: 12),
      filled: true,
      fillColor: Color(0xddffffff),
    );
  }
}