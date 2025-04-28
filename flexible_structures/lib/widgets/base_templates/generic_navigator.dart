


import 'package:flutter/material.dart';

abstract class GenericNavigator {

  Future<bool> pop<T extends Object?>(BuildContext context, [ T? result ]);

  moveToDefault(BuildContext context);
}
