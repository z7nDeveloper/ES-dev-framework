
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoute {

  // calls route page once, to add to the widget
  GoRoute getRoute();

  Widget getPage(BuildContext context, GoRouterState state);


  String get routePath;
}