import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;


  bool get dialogIsShowing => ModalRoute.of(this)?.isCurrent != true;

  T? tryRead<T>() {
    try {
      return read<T>();
    } catch (e) {
      return null;
    }
  }
}
