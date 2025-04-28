import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;


  bool get dialogIsShowing => ModalRoute.of(this)?.isCurrent != true;
}
